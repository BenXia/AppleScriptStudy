--
--  AppDelegate.applescript
--  AMultiplyBDemo
--
--  Created by Ben on 2018/9/11.
--  Copyright � 2018�� QQingiOSTeam. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	
	-- IBOutlets
	property theWindow : missing value
    property txtFieldOne : missing value
    property txtFieldTwo : missing value
    property totalLabel : missing value
    property calcButton : missing value

	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_

    on clickCalcButton_(sender)
       set a to ""&(stringValue() of txtFieldOne)
       set b to ""&(stringValue() of txtFieldTwo)
       
       -- display dialog "hello world"
       
       -- display alert "hello world"
       
       -- log "hello world"
       
       -- do shell script "echo hello > ~/Desktop/test.txt"
       
       -- osascript -e "display dialog \"hello world\""
       
       -- osascript ./������.scpt ��һ������ �ڶ������� ����������
       
       set c to a * b
       totalLabel's setStringValue_(c)
    end clickCalcButton_

end script


