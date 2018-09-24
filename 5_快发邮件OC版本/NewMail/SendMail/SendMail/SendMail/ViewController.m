//
//  ViewController.m
//  SendMail
//
//  Created by Ben on 2018/9/25.
//  Copyright © 2018年 iOSStudio. All rights reserved.
//

#import "ViewController.h"
#import "NewMailTool.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    [NewMailTool sendEmail:@"来自测试快发邮件的 OC 工程"
            messageContent:@"自定义内容"
            fileAttachment:@[]
                   fromWho:@"xiaxuqiang@changingedu.com"
                     toWho:@"352229402@qq.com"];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
