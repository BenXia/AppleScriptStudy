//
//  main.m
//  RoundHouseHelper
//
//  Created by Christian on 5/6/13.
//  Copyright (c) 2013 Drivetime. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, (const char **)argv);
}
