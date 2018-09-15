#import <Cocoa/Cocoa.h>

@interface ScriptViewAppDelegate : NSObject {
    NSWindow* window ;
	NSTextView* textView ;
}

@property (assign) IBOutlet NSWindow* window ;
@property (assign) IBOutlet NSTextView* textView ;

- (void)addLine:(NSString*)line ;

@end
