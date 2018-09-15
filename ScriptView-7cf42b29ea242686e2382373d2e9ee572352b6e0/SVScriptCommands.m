#import "ScriptViewAppDelegate.h"

@interface AddLineCommand : NSScriptCommand
@end

@implementation AddLineCommand
- (id)performDefaultImplementation {
	// Get the receiver/object of the command
	NSDictionary* args = [self evaluatedArguments] ;
	NSArray* values = [args allValues] ;
	if ([values count] != 1) {
		[self setScriptErrorNumber:10151] ;
		[self setScriptErrorString:[NSString stringWithFormat:@"Command 'add line' must have one and only one parameter."]] ;
	}
	NSString* newLine = [values objectAtIndex:0] ;
	if (![newLine isKindOfClass:[NSString class]]) {
		[self setScriptErrorNumber:10152] ;
		[self setScriptErrorString:[NSString stringWithFormat:@"Parameter to command 'add line' must be a string of text."]] ;
		return nil ;
	}
	
	[[NSApp delegate] addLine:newLine] ;
	
	return nil ;
}
@end


