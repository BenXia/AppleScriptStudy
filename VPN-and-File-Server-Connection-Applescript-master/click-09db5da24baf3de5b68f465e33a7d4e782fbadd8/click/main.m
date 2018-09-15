//
//  main.m
//  click
//
//  Created by Satoshi H on 2013/09/21.
//  Copyright (c) 2013年 Satoshi H. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
	[[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
	return NSApplicationMain(argc, (const char **)argv);
}
