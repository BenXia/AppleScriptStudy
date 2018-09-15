--
--  Created by Iain Moncrief on 2/27/17.
--  Copyright © 2017 Iain Moncrief. All rights reserved.
--

	

-- Please note, that this file will not wrok as is. These snippets need to be edited to fit your needs.


	-- IBOutlets
    
    global globalVar

    global serverConnectionStatus

    global isVPNConnected







-- This snippet is used to install a VPN service.
(**)
on installVPN_()
    tell application "Finder"
        activate
        set mconfigappfolder to (path to desktop folder as text) & "Folder:Test.mobileconfig"
        open mconfigappfolder
    end tell
end installVPN_



    -- Connecting to VPN
    (**)
    on connectToVPN_()

        checkConnection_()
        if serverConnectionStatus is true then
            
            set timer1 to 20 -- update to whatever time (in seconds) you feel is acceptable
            set isVPNConnected to false
            
            tell application "System Events"
                
                tell current location of network preferences
                    
                    set myVPNServiceName to "(VPN Service Name)"
                    set vpnConnectionInProgress to false
                    
                    -- Try to connect to VPN service
                    try
                        set VPNService to service myVPNServiceName
                        connect VPNService
                        set vpnConnectionInProgress to true
                    end try
                    
                    if vpnConnectionInProgress is true then
                        
                        -- keep checking until timer expires or connection is confirmed
                        repeat while timer > 0 and isVPNConnected is false
                            
                            if current configuration of VPNService is connected then
                                -- The VPN is connected!
                                set isVPNConnected to true
                                display notification "" with title "Connection Successful!" subtitle "You may now use the internet privately and safely!"
                                
                                --the user is connected if they got to here
                                
                            end if
                            
                            log isVPNConnected
                            
                            set timer1 to timer1 - 1
                            delay 1
                            
                        end repeat
                        
                    end if
                    
                end tell
                
            end tell
            
            if isVPNConnected is true then
                -- user connected
                display dialog "Connected"
            else
                --unable to connect
                display dialog "Cannot connect to VPN. Please try checking your username and password." buttons {"OK"} with icon 2
                
            end if
        else
        
            display dialog "Cannot connect to server. Please check your connection." buttons {"OK"} with icon 2

       end if

        end connectToVPN_



on checkConnection_()
    
    set IP_address to "google.com"
    
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
