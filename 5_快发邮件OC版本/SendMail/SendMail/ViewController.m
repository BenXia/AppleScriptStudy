//
//  ViewController.m
//  SendMail
//
//  Created by Ben on 2018/9/25.
//  Copyright © 2018年 iOSStudio. All rights reserved.
//

#import "ViewController.h"
#import "XPCScriptingBridgeProtocol.h"

@interface ViewController ()

@property (nonatomic) NSXPCConnection *scriptingBridgeServiceConnection;

@end;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    _scriptingBridgeServiceConnection = [[NSXPCConnection alloc] initWithServiceName:@"Ben.XPCScriptingBridge"];
    _scriptingBridgeServiceConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCScriptingBridgeProtocol)];
    [_scriptingBridgeServiceConnection resume];
}

- (void)viewDidAppear {
    [super viewDidAppear];
    
    [[_scriptingBridgeServiceConnection remoteObjectProxy] sendEmail:@"来自测试快发邮件的 OC 工程"
                                                      messageContent:@"自定义内容"
                                                      fileAttachment:@[]
                                                             fromWho:@"xiaxuqiang@changingedu.com"
                                                               toWho:@"352229402@qq.com"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)dealloc {
    [_scriptingBridgeServiceConnection invalidate];
}

@end
