//
//  main.m
//  NewMail
//
//  Created by Ben on 2018/9/25.
//  Copyright © 2018年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPCScriptingBridgeProtocol.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        NSXPCConnection *_scriptingBridgeServiceConnection = [[NSXPCConnection alloc] initWithServiceName:@"Ben.XPCScriptingBridge"];
        _scriptingBridgeServiceConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCScriptingBridgeProtocol)];
        [_scriptingBridgeServiceConnection resume];
        
        [[_scriptingBridgeServiceConnection remoteObjectProxy] sendEmail:@"来自测试快发邮件的 OC 工程"
                                                          messageContent:@"自定义内容"
                                                          fileAttachment:@[]
                                                                 fromWho:@"xiaxuqiang@changingedu.com"
                                                                   toWho:@"352229402@qq.com"];
        
        sleep(5);
        
        [_scriptingBridgeServiceConnection invalidate];
        
        sleep(5);
    }
    return 0;
}


