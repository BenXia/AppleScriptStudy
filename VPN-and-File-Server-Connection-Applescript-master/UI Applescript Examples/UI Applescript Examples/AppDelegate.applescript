--
--  AppDelegate.applescript
--  UI Applescript Examples
--
--  Created by Iain Moncrief on 5/19/17.
--  Copyright © 2017 Iain Moncrief. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	
	-- IBOutlets
	property theWindow : missing value
    
    property imageButton1 : missing value
    
    property label1 : missing value
	
    property progressBar : missing value
    
    property progressWheel : missing value
    
    property image1 : missing value
    
    property MyProgressBar : missing value -- Progress Bar IB Outlet
    
    property button3 : missing value
    
    global variable1
    
    
    
    
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
        
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
    
    
    
    
    
    
    
    on button1_(sender)
        tell progressWheel to startAnimation_(sender)
        repeat 5 times
        set c to 0
    repeat 100 times
        
            set c to c + 1
            delay 0.005
            tell MyProgressBar to setDoubleValue_(c) -- Tells Progress bar the % to go to
            if c > 99 then
                exit repeat -- If current repeat is 100 or more then cancels adding more
            end if
        end repeat
    end repeat
    end button1_
    
    
    
    on button2_(sender)
        tell progressWheel to stopAnimation_(sender)
        tell MyProgressBar to setDoubleValue_(0)
    end button2_
    
    
    
    
    
    
    
    
    on imageButton_(sender)
        set newImage1 to current application's NSImage's imageNamed_("happy.png")
        imageButton1's setImage_(newImage1)
        label1's setStringValue_("I'm Happy!")
        delay 1
        label1's setStringValue_("4")
        delay 1
        label1's setStringValue_("3")
        delay 1
        label1's setStringValue_("2")
        delay 1
        label1's setStringValue_("1")
        delay 1
        label1's setStringValue_("I'm Sad, Click Me")
        set newImage1 to current application's NSImage's imageNamed_("sad.png")
        imageButton1's setImage_(newImage1)
    end imageButton_
    
    
    
    
    
    
    
    
    
    
    on button3_(sender)
        set variable1 to 1
        repeat 7 times
        set variable1 to variable1 as string
        set c to variable1 & ".png"
        set newImage1 to current application's NSImage's imageNamed_(c)
        image1's setImage_(newImage1)
        set variable1 to variable1 + 1
        delay 1
        end repeat
    end button3_
    
end script
