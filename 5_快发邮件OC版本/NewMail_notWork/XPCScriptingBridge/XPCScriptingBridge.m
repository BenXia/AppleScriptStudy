//
//  XPCScriptingBridge.m
//  XPCScriptingBridge
//
//  Created by Ben on 2018/9/25.
//  Copyright © 2018年 iOSStudio. All rights reserved.
//

#import "XPCScriptingBridge.h"
#import <ScriptingBridge/ScriptingBridge.h>

#import "Mail.h"

@implementation XPCScriptingBridge

- (void)sendEmail:(NSString *)subject messageContent:(NSString *)body fileAttachment:(NSArray *)filePathArr fromWho:(NSString *)emailFrom toWho:(NSString *)emailTo {
    /* create a Scripting Bridge object for talking to the Mail application */
    MailApplication * mail = (MailApplication *)[[SBApplication alloc] initWithBundleIdentifier:@"com.apple.Mail"];
    /* set ourself as the delegate to receive any errors */
    //    mail.delegate = self;
    [mail activate];
    /* create a new outgoing message object */
    //    MailOutgoingMessage *emailMessage = [[[mail classForScriptingClass:@"outgoing message"] alloc] initWithProperties:
    //                                         [NSDictionary dictionaryWithObjectsAndKeys:
    //                                          subject, @"subject",
    //                                          body, @"content",
    //                                          nil]];
    MailOutgoingMessage *emailMessage = [[NSClassFromString(@"MailOutgoingMessage") alloc] initWithProperties:
                                         @{@"subject": subject,
                                           @"content" : body}];
    
    /* Handle a nil value gracefully. */
    if(!emailMessage)
        return;
    
    /* add the object to the mail app  */
    /* set the sender, show the message */
    
    [[mail outgoingMessages] addObject:emailMessage];
    
    emailMessage.sender = emailFrom;
    
    emailMessage.visible = YES;
    
    /* create a new recipient and add it to the recipients list */
    MailToRecipient *theRecipient = [[[mail classForScriptingClass:@"to recipient"] alloc] initWithProperties:
                                     [NSDictionary dictionaryWithObjectsAndKeys:
                                      emailTo, @"address",
                                      nil]];
    //MailToRecipient *theRecipient = [[NSClassFromString(@"MailToRecipient") alloc] initWithProperties:
    //                                     @{@"address": emailTo}];
    /* Handle a nil value gracefully. */
    if(!theRecipient)
        return;
    [emailMessage.toRecipients addObject: theRecipient];
    
    /* add an attachment, if one was specified */
    for(NSString *filePath in filePathArr){
        NSString *attachmentFilePath = filePath;
        
        if ( [attachmentFilePath length] > 0 ) {
            MailAttachment *theAttachment;
            
            /* In Snow Leopard, the fileName property requires an NSString representing the path to the
             * attachment.  In Lion, the property has been changed to require an NSURL.   */
            SInt32 osxMinorVersion;
            Gestalt(gestaltSystemVersionMinor, &osxMinorVersion);
            
            /* create an attachment object */
            if(osxMinorVersion >= 7)
                //            theAttachment = [[[mail classForScriptingClass:@"attachment"] alloc] initWithProperties:
                //                             [NSDictionary dictionaryWithObjectsAndKeys:
                //                              [NSURL fileURLWithPath:filePath], @"fileName",
                //                              nil]];
                theAttachment = [[NSClassFromString(@"MailAttachment") alloc] initWithProperties:
                                 @{@"fileName": [NSURL URLWithString:filePath]}];
            else
            /* The string we read from the text field is a URL so we must create an NSURL instance with it
             * and retrieve the old style file path from the NSURL instance. */
                //            theAttachment = [[[mail classForScriptingClass:@"attachment"] alloc] initWithProperties:
                //                             [NSDictionary dictionaryWithObjectsAndKeys:
                //                              [[NSURL URLWithString:attachmentFilePath] path], @"fileName",
                //                              nil]];
                theAttachment = [[NSClassFromString(@"MailAttachment") alloc] initWithProperties:
                                 @{@"fileName": [NSURL URLWithString:attachmentFilePath]}];
            
            /* Handle a nil value gracefully. */
            if(!theAttachment)
                return;
            
            /* add it to the list of attachments */
            [[emailMessage.content paragraphs] addObject:theAttachment];
        }
    }
    
    /* send the message */
    //[emailMessage send];
}

@end
