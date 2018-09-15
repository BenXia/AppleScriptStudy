//
//  NSWindow+MyriadHelpers.h
//
//  Created by Shane Stanley. v2.0
//  <sstanley@myriad-com.com.au>.
//  'AppleScriptObjC Explored' <http://www.macosxautomation.com/applescript/apps/>
//
// This category adds methods to windows to make it easier to show them as sheets. See sample for typical usage.
//
//  ******************************************************************
//  v2.0 is for use in either ARC or garbage collected projects
//  ******************************************************************

#import <Cocoa/Cocoa.h>


@interface NSWindow (MyriadHelpers)

/* Shows window as a sheet over other window. Close it by calling NSApp's endSheet_(<theSheet/Window>) in the handler of whatever triggers the close. */
-(void)showOver:(NSWindow *)window;
	
/* As above, with the selector in calling: called if the sheet isn't closed within the specified number of seconds. If the selector is in the app delegate, you can just pass the selector (which takes a single argument) as a string, otherwise pass it a list of the selector plus the script it's in (usually *me*).  The argument passed to the selector is meaningless (-1999). */
-(void)showOver:(NSWindow *)window calling:(id)selOrArray onlyAfter:(double)seconds;

@end
