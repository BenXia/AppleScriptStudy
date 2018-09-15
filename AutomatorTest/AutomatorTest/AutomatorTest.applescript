--  AutomatorTest.applescript
--  AutomatorTest

--  Created by Ben on 2018/9/11.
--  Copyright © 2018年 QQingiOSTeam. All rights reserved.

script AutomatorTest
	property parent : class "AMBundleAction"
	
	on runWithInput_fromAction_error_(input, anAction, errorRef)
		-- Add your code here, returning the data to be passed to the next action.
		
		return input
	end runWithInput_fromAction_error_
	
end script
