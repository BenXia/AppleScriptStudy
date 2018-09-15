//
//  main.m
//  AMultiplyBDemo
//
//  Created by Ben on 2018/9/11.
//  Copyright © 2018年 QQingiOSTeam. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, argv);
}
