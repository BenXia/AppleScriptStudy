#import "ScriptViewAppDelegate.h"

@implementation ScriptViewAppDelegate

@synthesize window ;
@synthesize textView ;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

/* In case user doesn't want the log and closes the window, we don't
 want to leave our process running.  This will cause an error if
 AppleScript tries to quit us, but oh well AppleScript should 'try'
 */
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)app {
	return YES ;
}

- (void)addLine:(NSString*)line {
	NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSFont systemFontOfSize:11.0], NSFontAttributeName,
								nil] ;
	NSString* text = [[textView textStorage] string] ;
	if (text) {
		text = [text stringByAppendingString:line] ;
	}
	else {
		text = line ;
	}
	text = [text stringByAppendingString:@"\n"] ;
	NSAttributedString* as = [[NSAttributedString alloc] initWithString:text
															 attributes:attributes] ;
	[[textView textStorage] setAttributedString:as] ;
	[as release] ;
	
	// Scroll to bottom…
	// Hey, in FileGoBack, when I wanted a text view to stay scrolled to the top,
	// it would scroll to the bottom, and so I did the opposite, scrollPoint:NSZeroPoint.
	// Maybe the 10.5 SDK defaults to scrolling to the top, and the 10.7 SDK
	// defaults to scrolling to the bottom?
	[textView scrollRangeToVisible:NSMakeRange([[textView string] length], 0)] ;

	[textView display] ;
}

@end
