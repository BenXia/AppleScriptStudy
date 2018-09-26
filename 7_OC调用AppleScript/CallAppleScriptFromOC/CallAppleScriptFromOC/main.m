//
//  main.m
//  CallAppleScriptFromOC
//
//  Created by Ben on 2018/9/26.
//  Copyright © 2018年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 第一种方法将 AppleScript 脚本写到变量字符串里使用
        NSAppleEventDescriptor *eventDescriptor = nil;
        NSAppleScript *script = nil;
        NSString *scriptSource =
@"--Variables\r"
"set recipientName to \"Ben\"\r"
"set recipientAddress to \"352229402@qq.com\"\r"
"set theSubject to \"AppleScript Automated Email\"\r"
"set theContent to \"This email was created and sent using AppleScript!\"\r"
"\r"
"--Mail Tell Block\r"
"tell application \"Mail\"\r"
"\r"
"--Create the message\r"
"set theMessage to make new outgoing message with properties {subject:theSubject, content:theContent, visible:true}\r"
"\r"
"--Set a recipient\r"
"tell theMessage\r"
"make new to recipient with properties {name:recipientName, address:recipientAddress}\r"
"\r"
"--Send the Message\r"
"-- send\r"
"\r"
"end tell\r"
"end tell\r"
"\r"
"tell application \"System Events\"\r"
"set frontmost of process \"Mail\" to true\r"
"end tell";

        if (scriptSource) {
            script = [[NSAppleScript alloc] initWithSource:scriptSource];
            if (script) {
                eventDescriptor = [script executeAndReturnError:nil];
                if (eventDescriptor) {
                    NSLog(@"%@", [eventDescriptor stringValue]);
                }
            }
        }
        
        
        // 第二种方法从文件中读取 AppleScript 脚本
//        NSAppleEventDescriptor *eventDescriptor = nil;
//        NSAppleScript *script = nil;
//        NSString *scriptPath = @"/Users/xiaxuqiang/Documents/知识体系/Apple/iOS/知识点/脚本自动化/AppleScript/5_快发邮件AS版本.scpt";
//        if (scriptPath) {
//            script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:scriptPath] error:nil];
//            if (script) {
//                eventDescriptor = [script executeAndReturnError:nil];
//                if (eventDescriptor) {
//                    NSLog(@"%@", [eventDescriptor stringValue]);
//                }
//            }
//        }
    }
    return 0;
}
