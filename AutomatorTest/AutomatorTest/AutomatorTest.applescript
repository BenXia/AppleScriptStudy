--  AutomatorTest.applescript
--  AutomatorTest

--  Created by Ben on 2018/9/11.
--  Copyright © 2018年 QQingiOSTeam. All rights reserved.

script AutomatorTest
	property parent : class "AMBundleAction"
    
    -- IBOutlets
    property txtFieldOne : missing value
    property txtFieldTwo : missing value
    property totalLabel : missing value
    property calcButton : missing value
    
    property parameters : missing value
	
	on runWithInput_fromAction_error_(input, anAction, errorRef)
		-- Add your code here, returning the data to be passed to the next action.
        set a to |leftNum| of parameters
        set b to |rightNum| of parameters
        
        display dialog "Value of leftNum:" & a
        
        -- set c to a * b
        -- set output to input * c
        -- totalLabel's setStringValue_(c)
        
		return b
	end runWithInput_fromAction_error_
    
    (*
    on clickCalcButton_(sender)
        -- set a to (|leftNum| of parameter) as integer
        -- set b to (|rightNum| of parameter) as integer
        
        set a to valueForKey_("leftNum") of parameter() of me
        set b to valueForKey_("rightNum") of parameter() of me
        
        set c to a * b
        
        totalLabel's setStringValue_(c)
    end clickCalcButton_
     *)
	
end script
