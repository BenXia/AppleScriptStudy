--
--  Created by Iain Moncrief on 2/27/17.
--  Copyright © 2017 Iain Moncrief. All rights reserved.
--


-- Please note, that this file will not wrok as is. These snippets need to be edited to fit your needs.



    global serverConnectionStatus
    

on checkConnection_()
    
    set IP_address to "(ANY STABLE WEBSITE)"
    
    set serverConnectionStatus to false
    
        -- Initialise if conectivity is valid
        try
            
            set ping to (do shell script "ping -c 2 " & IP_address)

            set serverConnectionStatus to true
            
        on error
            
            -- if we get here, the ping failed
            
            set serverConnectionStatus to false
            
        end try
        
end checkConnection_


-- Connecting to cloud
    (**)
    on cloud_()

checkConnection_()

 if serverConnectionStatus is true then

set volumeString to "afp://" & "" & ":" & "null" & "@YourDomain"
-- having the volume string in that configuration, will give the user a dialog to securley put their username and password into. the user also has the feature to save the user and pass to their keychain.

try
    
    mount volume volumeString
    --Cloud is connected after this point!
    
    on error
    
       -- could not connect to cloud
        display dialog "Cannot connect to cloud. Please try checking your username and password." buttons {"OK"} with icon 2

end try

else
-- could not connect to cloud
display dialog "Cannot connect to Cloud. Please check your connection." buttons {"OK"} with icon 2

end if

end cloud_
    
