//
//  XPCScriptingBridge.h
//  XPCScriptingBridge
//
//  Created by Ben on 2018/9/25.
//  Copyright © 2018年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPCScriptingBridgeProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface XPCScriptingBridge : NSObject <XPCScriptingBridgeProtocol>
@end
