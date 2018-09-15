--
--  AppDelegate.applescript
--  click
--
--  Created by Satoshi H on 2013/09/21.
--  Copyright (c) 2013”N Satoshi H. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	
	on ButtonPresssed:sender
		set tmp to AppleScript's text item delimiters
		set AppleScript's text item delimiters to {","}
		set mouseLocB to word 4 of (do shell script "/opt/local/bin/cliclick p") as text
		set mouseLocBX to text item 1 of mouseLocB as integer
		display dialog mouseLocBX
		set mouseLocBY to text item 2 of mouseLocB as integer
		display dialog mouseLocBY
		
		set mouseLoc to mouseLocB
		set mouseLocX to mouseLocBX
		set mouseLocY to mouseLocBY
		
		repeat while (mouseLocX - mouseLocBX) ^ 2 + (mouseLocY - mouseLocBY) ^ 2 < 25
			set mouseLoc to word 4 of (do shell script "/opt/local/bin/cliclick  p c:. c:. c:. c:. c:.") as text
			--set mouseLoc to word 4 of (do shell script "/opt/local/bin/cliclick  p c:. c:. c:. c:. c:. c:. c:. c:. c:. c:.  c:. c:. c:. c:. c:. c:. c:. c:. c:. c:.  c:. c:. c:. c:. c:. c:. c:. c:. c:. c:.  c:. c:. c:. c:. c:. c:. c:. c:. c:. c:.  c:. c:. c:. c:. c:. c:. c:. c:. c:. c:.  ") as text
			set mouseLocX to text item 1 of mouseLoc as integer
			set mouseLocY to text item 2 of mouseLoc as integer
		end repeat
		set AppleScript's text item delimiters to tmp
		display dialog mouseLocB & " : " & mouseLoc
	end ButtonPresssed:
	
	on applicationWillFinishLaunching:aNotification
		-- Insert code here to initialize your application before any files are opened
		
	end applicationWillFinishLaunching:
	
	on applicationShouldTerminate:sender
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate:
	
end script
