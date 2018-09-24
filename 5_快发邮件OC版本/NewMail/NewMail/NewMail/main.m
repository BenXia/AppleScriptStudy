//
//  main.m
//  NewMail
//
//  Created by Ben on 2018/9/25.
//  Copyright © 2018年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewMailTool.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        [NewMailTool sendEmail:@"来自测试快发邮件的 OC 工程"
                messageContent:@"自定义内容"
                fileAttachment:@[]
                       fromWho:@"xiaxuqiang@changingedu.com"
                         toWho:@"352229402@qq.com"];
    }
    return 0;
}


