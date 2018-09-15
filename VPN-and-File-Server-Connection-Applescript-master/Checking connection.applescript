--
--  Created by Iain Moncrief on 2/27/17.
--  Copyright © 2017 Iain Moncrief. All rights reserved.
--



-- Please note, that this file will not wrok as is. These snippets need to be edited to fit your needs.


    
    -- This is the global variable
    global serverConnectionStatus
    

--Connectivity checker
(*
 to check the users connection, anywhere in your code put:
 
 checkConnection_()
 if serverConnectionStatus is true then
 display dialog "we got internet"
 end tell
 
 Please make sure that you have the following code in your project allong with the global variable defined at the top "serverConnectionStatus" like in the begining of this example.
 *)
on checkConnection_()
    set IP_address to "(ANY STABLE WEBSITE)"
    
    set serverConnectionStatus to false
    
        -- Initialise if conectivity is valid.
        try
            
            set ping to (do shell script "ping -c 2 " & IP_address)
            
            set serverConnectionStatus to true
            
        on error
            
            -- If we get here, the ping failed, and the user is not connected.
            
            set serverConnectionStatus to false
            
        end try
    
end checkConnection_

checkConnection_()
if serverConnectionStatus is true then
    display dialog "we got internet"
    (*insert internet needing code here*)
    else
    display dialog "wupps, fix ur wifi"
end tell


