//
//  NewMailTool.h
//  NewMail
//
//  Created by Ben on 2018/9/25.
//  Copyright © 2018年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewMailTool : NSObject
    
+ (void)sendEmail:(NSString *)subject messageContent:(NSString *)body fileAttachment:(NSArray *)filePathArr fromWho:(NSString *)emailFrom toWho:(NSString *)emailTo;

@end

NS_ASSUME_NONNULL_END
