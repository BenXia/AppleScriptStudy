	//
	//  NSAlert+MyriadHelpers.m
	//
//  Created by Shane Stanley. v2.0.2
//  <sstanley@myriad-com.com.au>.
//  'AppleScriptObjC Explored' <http://www.macosxautomation.com/applescript/apps/>
//
//  v2.0.2 is for use in either ARC or garbage collected projects
// Projects must be compiled under 10.9 or later. Runs under 10.6 or later.

#import "NSAlert+MyriadHelpers.h"


@interface NSAlert (MyriadHelpersPrivate) 
	// private handlers
-(void)privateAlertSheetDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)stuff;
-(NSArray *)privateVerifySelector:(id)selOrArray;
-(void)privateCloseAlertSheet:(NSTimer *)timer;
-(void)privateCloseAlert:(NSTimer *)timer;
-(NSString *)privateResultToButton:(NSInteger)result;

@end

@implementation NSAlert (MyriadHelpers)

+(NSAlert *)makeAlert:(NSString *)message buttons:(NSArray *)buttons text:(NSString *)text {
	NSAlert *alert = [[self alloc] init];
	[alert setMessageText:message];
	[alert setInformativeText:text];
	if ([buttons count] == 0) {
		[alert addButtonWithTitle:@"OK"];		
	} else {
		NSEnumerator *enumerator = [buttons reverseObjectEnumerator];
		NSString *label;
		while ((label = [enumerator nextObject])) {
			[alert addButtonWithTitle:label];
		}
	}
	return alert;
}

-(NSString *)showModal {
	NSInteger result = [self runModal];
	return [self privateResultToButton:result];
}

-(NSArray *)showModalWithSuppress {
	[self setShowsSuppressionButton:YES];
	NSString *button = [self showModal];
    if ([[self suppressionButton] state] == NSOnState) {
		return [NSArray arrayWithObjects:button, [NSNumber numberWithBool:YES], nil];
	}
	return [NSArray arrayWithObjects:button, [NSNumber numberWithBool:NO], nil];
}

-(NSString *)showModalWait:(double)seconds {
	if (seconds < 1.0) seconds = 1.0;
	NSTimer *timer = [NSTimer timerWithTimeInterval:seconds 
											 target:self 
										   selector:@selector(privateCloseAlert:) // will abort modal
										   userInfo:nil 
											repeats:NO]; 
	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSModalPanelRunLoopMode];
	NSString *button = [self showModal];
	[timer invalidate];
	return button;
}

-(void)showOver:(NSWindow *)window calling:(id)selOrArray {
		// verifies selector and object; problems are logged 
	NSArray *contextInfo = [self privateVerifySelector:selOrArray];
	if (!contextInfo) {
		return;
	}
        // use this for 10.9+
    if ([self respondsToSelector:@selector(beginSheetModalForWindow:completionHandler:)]) {
        [self beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
            NSString *buttonName = [self privateResultToButton:returnCode];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [[contextInfo objectAtIndex:1] performSelector:NSSelectorFromString([contextInfo objectAtIndex:0]) withObject:buttonName];
#pragma clang diagnostic pop
        }];
        return;
    }
        // pre-10.9 code
    [self beginSheetModalForWindow:window
					 modalDelegate:self 
					didEndSelector:@selector(privateAlertSheetDidEnd:returnCode:contextInfo:) 
     // contextInfo:(__bridge_retained void *)contextInfo];
                       contextInfo:(void *)CFBridgingRetain(contextInfo)];
}

-(void)showOverWithSuppress:(NSWindow *)window calling:(id)selOrArray {
		// verifies selector and object; problems are logged 
	NSArray *contextInfo = [self privateVerifySelector:selOrArray];
	if (!contextInfo) {
		return;
	}
        // use this for 10.9+
    if ([self respondsToSelector:@selector(beginSheetModalForWindow:completionHandler:)]) {
        [self beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
            NSString *buttonName = [self privateResultToButton:returnCode];
            NSInteger state = [[self suppressionButton] state];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [[contextInfo objectAtIndex:1] performSelector:NSSelectorFromString([contextInfo objectAtIndex:0]) withObject:[NSArray arrayWithObjects:buttonName, [NSNumber numberWithInteger:state], nil]];
#pragma clang diagnostic pop
        }];
        return;
    }
        // pre-10.9 code
	[self setShowsSuppressionButton:YES];
	contextInfo = [contextInfo arrayByAddingObject:[NSNumber numberWithBool:YES]];
	[self beginSheetModalForWindow:window 
					 modalDelegate:self 
					didEndSelector:@selector(privateAlertSheetDidEnd:returnCode:contextInfo:) 
     // contextInfo:(__bridge_retained void *)contextInfo];
                       contextInfo:(void *)CFBridgingRetain(contextInfo)];
}

-(void)showOver:(NSWindow *)window calling:(id)selOrArray wait:(double)seconds {
		// verifies selector and object; problems are logged 
	NSArray *contextInfo = [self privateVerifySelector:selOrArray];
	if (!contextInfo) {
		return;
    }
    if (seconds < 1.0) seconds = 1.0;
        // use this for 10.9+
    if ([self respondsToSelector:@selector(beginSheetModalForWindow:completionHandler:)]) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:seconds
                                                          target:self
                                                        selector:@selector(privateCloseAlertSheet:)
                                                        userInfo:nil
                                                         repeats:NO];
        [self beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
            [timer invalidate];
            NSString *buttonName = [self privateResultToButton:returnCode];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [[contextInfo objectAtIndex:1] performSelector:NSSelectorFromString([contextInfo objectAtIndex:0]) withObject:buttonName];
#pragma clang diagnostic pop
        }];
        return;
    }
        // pre-10.9 code
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:seconds
													  target:self 
													selector:@selector(privateCloseAlertSheet:)
													userInfo:nil 
													 repeats:NO];
	NSArray *contextInfoPlus = [contextInfo arrayByAddingObjectsFromArray:[NSArray arrayWithObjects:[NSNumber numberWithBool:NO], timer, nil]];
	[self beginSheetModalForWindow:window 
					 modalDelegate:self 
					didEndSelector:@selector(privateAlertSheetDidEnd:returnCode:contextInfo:) 
     // contextInfo:(__bridge_retained void *)contextInfoPlus];
                       contextInfo:(void *)CFBridgingRetain(contextInfoPlus)];
}

-(void)privateCloseAlert:(NSTimer *)timer {
    [NSApp abortModal];
}

-(void)privateCloseAlertSheet:(NSTimer *)timer {
    [[[self window] sheetParent] endSheet:[self window] returnCode:NSRunAbortedResponse];
}

    // pre-10.9 code
- (void)privateAlertSheetDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)stuff {
    NSArray *newStuff = (NSArray *)CFBridgingRelease(stuff);
	if ([newStuff count] == 4) {
		[[newStuff objectAtIndex:3] invalidate];
	}
	NSString *sel = [newStuff objectAtIndex:0];
	id object = [newStuff objectAtIndex:1];
	NSString *button = [self privateResultToButton:returnCode];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	if (([newStuff count] > 2) && ([newStuff objectAtIndex:2] == [NSNumber numberWithBool:YES])) {
		NSInteger state = [[self suppressionButton] state];
		[object performSelector:NSSelectorFromString(sel) 
					 withObject:[NSArray arrayWithObjects:button, [NSNumber numberWithInteger:state], nil]];
	} else {	
		[object performSelector:NSSelectorFromString(sel) 
					 withObject:button];
	}
#pragma clang diagnostic pop
}

-(NSString *)privateResultToButton:(NSModalResponse)result
{
    NSInteger index;
    switch (result) {
        case NSModalResponseAbort:
            return @"Gave up"; // should only happen in call from showModalSeconds: or showOver:calling:seconds:
            break;
            
        case NSModalResponseContinue:
            NSLog(@"showModal error: runModal returned %ld, NSModalResponseContinue?", result);
            return @"Negative result"; // shouldn't happen
            break;
        
        case NSAlertFirstButtonReturn:
            index = 0;
            break;
            
        case NSAlertSecondButtonReturn:
            index = 1;
            break;
            
        case NSAlertThirdButtonReturn:
            index = 2;
            break;
            
        default:
            index = ((int)result % 1000);
            break;
    }
	NSArray *buttons = [self buttons];
    NSUInteger buttonsCount = [buttons count];
	if (buttonsCount == 0) {
		return @"OK"; // error alerts have no buttons, return OK
	}
	if (buttonsCount < (index + 1)) {
		NSLog(@"showModal error: expected button %ld, only %lu buttons found.", index, [buttons count]);
		return @"No such button"; // shouldn't happen
	}
	return [[buttons objectAtIndex:index] title];
}

-(NSArray *)privateVerifySelector:(id)selOrArray {
		// if selOrArray is string it's the selector name and the object is app delegate, 
		// else it's an array of selector name plus object
	NSString *sel;
	id object;
	if ([selOrArray isKindOfClass:[NSString class]]) {
		sel = selOrArray;
		object = [NSApp delegate];
	} else if ([selOrArray isKindOfClass:[NSArray class]]) {
		if ([(NSArray *)selOrArray count] == 2) {
			sel = [(NSArray *)selOrArray objectAtIndex:0];
			object = [(NSArray *)selOrArray objectAtIndex:1];
		} else if ([(NSArray *)selOrArray count] == 1) {
			sel = [(NSArray *)selOrArray objectAtIndex:0];
			object = [NSApp delegate];
		} else {
			NSLog(@"The calling: argument is invalid; should be selector name, or {selector name, its object} list");
			return nil;
		}
	}
		//verify selectors
	NSUInteger byColon = [[sel componentsSeparatedByString:@":"] count];
	if ([[sel componentsSeparatedByString:@"_"] count] > 1) {
		NSLog(@"Invalid selector '%@', do not use underscores in selector name.", sel);
		return nil;
	} else if (byColon == 1) { //
		NSLog(@"Invalid selector '%@', should be single colon at end.", sel);
		return nil;
	} else if (byColon == 2) {
		if (![sel hasSuffix:@":"]) {
			NSLog(@"Invalid selector '%@', colon should be at end.", sel);
			return nil;
		}
	}else {
		NSLog(@"Invalid selector '%@'; takes a single argument.", sel);
		return nil;
	}
	if (![object isKindOfClass:[NSObject class]]) {
		NSLog(@"The object argument '%@' is not a valid object.", object);
		return nil;
	}
	if (![object respondsToSelector:NSSelectorFromString(sel)]) {
		NSLog(@"No selector called '%@' found in object '%@'.", sel, object);
		return nil;
	}
	return [NSArray arrayWithObjects:sel, object, nil];		
}

@end
