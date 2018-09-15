//
//  main.m
//  UI Applescript Examples
//
//  Created by Iain Moncrief on 5/19/17.
//  Copyright © 2017 Iain Moncrief. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, argv);
}
