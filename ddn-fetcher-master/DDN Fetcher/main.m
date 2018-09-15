//
//  main.m
//  DDN Fetcher
//
//  Created by Eric Shepherd on 8/3/18.
//  Copyright © 2018 Mozilla. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
  [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
  return NSApplicationMain(argc, argv);
}
