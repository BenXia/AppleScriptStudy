//
//  NSAlert+MyriadHelpers.h
//
//  Created by Shane Stanley. v2.0.2
//  <sstanley@myriad-com.com.au>.
//  'AppleScriptObjC Explored' <http://www.macosxautomation.com/applescript/apps/>
//
// This category adds methods to alerts to make them simpler to use, especially as sheets. See sample for typical usage.
//
//  v2.0.2 is for use in either ARC or garbage collected projects
// Projects must be compiled under 10.9 or later. Runs under 10.6 or later.

#import <Cocoa/Cocoa.h>

@interface NSAlert (MyriadHelpers) 

/* Returns an alert you can display: first argument is the bold message, buttons is a list of button titles, and text is the detailed text. */
+ (NSAlert *)makeAlert:(NSString *)message buttons:(NSArray *)buttons text:(NSString *)text;

/* Shows the alert modally. Returns the name of the button pressed. */
-(NSString *)showModal;

/* Shows the alert modally, with the suppression button. Returns an array containing the name of the button pressed plus the state of the suppression button. */
-(NSArray *)showModalWithSuppress;

/* As showModal, but giving up after the number of seconds. Returns "Gave up" if it timed out. */
-(NSString *)showModalWait:(double)seconds;

/* Shows the alert as a sheet over a window, calling a handler when closed. If the handler is in the app delegate, you can just pass the selector as a string for calling:, otherwise pass it a list of the selector plus the script it's in (usually *me*). The single argument passed to the selector is the name of the button pressed. */
-(void)showOver:(NSWindow *)window calling:(id)selOrArray;

/* As above, except the argument passed to the selector is a list of the name of the button pressed plus the state of the suppression checkbox (true or false). */
 -(void)showOverWithSuppress:(NSWindow *)window calling:(id)selOrArray;
	
/* As showOver:calling:, but giving up after the number of seconds. Returns "Gave up" if it timed out. */
 -(void)showOver:(NSWindow *)window calling:(id)selOrArray wait:(double)seconds;


	
@end
