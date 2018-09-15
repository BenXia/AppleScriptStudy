--
--  AppDelegate.applescript
--  RoundHouseHelper
--
--  Created by Christian on 5/6/13.
--  Copyright (c) 2013 Drivetime. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
    
    --Preferences
    property defaults : missing value
    --Windows
    property MainWindow : missing value
	property MainView : missing value
	property SearchView : missing value
	property blankView : missing value
    property CacheWindow : missing value
    property PreferencesWindow : missing value
    property ReshootWindow : missing value
    property doubleCheckWindow : missing value
    property tempWindow : missing value
    property existsWindow : missing value
    --Main Processing Window
    property MainBar1 : missing value
    property MainBar2 : missing value
    property MainDetail1 : missing value
    property MainDetail2 : missing value
    property ArchiveButton : missing value
    property mainPauseButton : missing value
    --Searching/Begin Window
    property searchBar1 : missing value
    property searchDetail1 : missing value
    property searchButton1 : missing value
    --Preferences Window
    property savefolderlocLabel : missing value
    property rawFolderloclabel : missing value
    property drop1Indicator : missing value
    property drop2Indicator : missing value
    property drop3Indicator : missing value
    property LogWindow : missing value
    --Cache Window
    property cacheIndicator : missing value
    property cachecancelbutton : missing value
    property cachepausebutton : missing value
    property cachelabel : missing value
    property cancelCache : false
    property pauseCache : false
    property cacheWait : 1
    --Reshoot Window
    property cancelReshootNew : false
    property aReshootNew : missing value
    property bReshootNew : missing value
    --Master State
    property pauseUser : false
    property reqReshoot : false
    property lastTask : null
    property meFinished : false
    property reshootSel : null
    property CacheCleared : false
    property isPaused : false
    property finishedProcessing : false
    property NumberChanged : false
    --Download Folders
    property Download1_folder : null
	property Download2_folder : null
	property Download3_folder : null
    property Download4_folder : null
    property processedFolder : null
    property prearchiveFolder : null
    property Download4FinalFolder : null
    --Droplets
    property Droplet1Location : null
    property Droplet2Location : null
    property Droplet3Location : null
    --Image Processing
    property imageNumber : null
    property processNumber : null
    property curNumber : null
    property processImage : null
    property curDownloadFolder : null
    property curBasename : null
    property curDroplet : null
    property processImageName : null
    property Delay1 : 0.3
    property dropletTimeout : 0
    --Image Archiving
    property carNumber : null
    property overwrite : false
    property files_exist : false
    property saved : true
    --DoubleCheckWindow
    property doubleCheckLabel : missing value
    property doubleCheckYesHandler : null
    property doubleCheckNoHandler : null
    --Temp Progress Window
    property tempBar1 : missing value
    property tempDetail1 : missing value
    --Already exists window
    property existsSelection : "Overwrite"
    property existsNumber : missing value
    property existsTextField : missing value
    --Globals
    property dropletFolder : null
    property drop1Name : "Download1_Droplet"
    property drop2Name : "Download2_Droplet"
    property drop3Name : "Download3_Droplet"
    property initializing : true
    property clearCacheTimer : 1
    property ClearCacheCountDown : true
    property RoundHouseHelper_folder : null
    property curView : null
    property curTempMaxValue : null
    property saveFolderloc : null
    property rawFolderloc : null
    property dropletsExist : null
    property D4exists : false
    
    
    (* ======================================================================
                            Handlers for Processing! 
     ====================================================================== *)
    
    --CLEAR CACHE HANDLER
    on clearCache()
        
        --Reset for start if this is my first round
        if clearCacheTimer = 1 then resetForStart()
        
        --Make sure the cancel button was not pressed
        if ClearCacheCountDown = true and cancelCache = false and pauseCache = false then
            --Do 5 second countdown
            log "Clear Cache..." & clearCacheTimer
            tell cacheIndicator to setIntValue_(clearCacheTimer - 1)
            tell cachelabel to setStringValue_("Preparing to Clear Cache...(" & (6 - clearCacheTimer) & ")")
            set clearCacheTimer to clearCacheTimer + 1
            if clearCacheTimer = 7 then
                set ClearCacheCountDown to false
                set clearCacheTimer to 1
            end if
            performSelector_withObject_afterDelay_("clearCache", missing value, cacheWait)
        else if ClearCacheCountDown = false and cancelCache = false and pauseCache = false then
            --After the coutdown we can now clear the cache
            set CacheFolderList to {"Download1", "Download2", "Download3", "Download4", "Download4Final", "Processed", "Prearchive"}
            tell cachelabel to setStringValue_("Clearing Cache..." & (item clearCacheTimer of CacheFolderList) as string)
            log_event("Clear Cache...Clearing " & (item clearCacheTimer of CacheFolderList) as string)
            --delete all files in folder
            do shell script "rm -rf " & POSIX path of (RoundHouseHelper_folder & item clearCacheTimer of CacheFolderList & ":*" as string)
            set clearCacheTimer to clearCacheTimer + 1
            if clearCacheTimer = 8 then
                set clearCacheTimer to 1
                set ClearCacheCountDown to true
                tell cachelabel to setStringValue_("Clearing Cache...Done!")
                delay 1
                --reset window
                tell current application's NSApp to endSheet_(CacheWindow)
                tell cacheIndicator to setIntValue_(0)
                set CacheCleared to true
                log_event("Clear Cache...Finished")
            else
                performSelector_withObject_afterDelay_("clearCache", missing value, 0.1)
            end if
        else if pauseCache = true and cancelCache = false then
            --Pause clear cache
            performSelector_withObject_afterDelay_("clearCache", missing value, 1)
        else if cancelCache = true then
            --End clear Cache
            set clearCacheTimer to 1
            set ClearCacheCountDown to true
            tell cachelabel to setStringValue_("Clearing Cache...Canceled!")
            set cancelCache to false
            delay 1
            --Reset window
            tell current application's NSApp to endSheet_(CacheWindow)
            tell cacheIndicator to setIntValue_(0)
            tell cachelabel to setStringValue_("Preparing to Clear Cache...")
            --try to reset the pause button
            try
                tell cachepausebutton to setState_(0)
                set pauseCache to false
            end try
            log_event("Clear Cache...CANCELED BY USER")
        end if
        
        --When the cache is cleared, begin searching.
        if CacheCleared is true then
            performSelector_withObject_afterDelay_("prepareStart", missing value, 0.5)
            set CacheCleared to false
        end if
    end ClearCache_
    
    --PREPARE TO START SEARCHING
    on prepareStart()
        log_event("Preparing to start...")
        --Check for droplets
        log_event("Preparing to start...Check for Droplets")
        checkDroplets_(me)
        if droplet1exist of dropletsExist is true and droplet2exist of dropletsExist is true and droplet3exist of dropletsExist is true then
            log_event("Preparing to start...Droplets ok!")
        else
            log_event("Preparing to start...DROPLETS MISSING")
            display dialog "A Droplet is missing, Please replace them in the peferences" buttons ("Ok") default button 1 with icon (stop)
            return
        end if
        --Check for download folders
        log_event("Preparing to start...Check Save-Raw Folders")
        retrieveDefaults_(me)
        try
            tell app "Finder" to set testsave to saveFolderloc as alias
            tell app "Finder" to set testraw to rawFolderloc as alias
        on error errmsg
            log_event("Preparing to start...SAVE-RAW FOLDER MISSING")
            display dialog "The Save or Raw folder appears to be missing. Please make sure the folders set in preferences exist." buttons ("Ok") default button 1 with icon (stop)
            return
        end try
        
        performSelector_withObject_afterDelay_("startSearch", missing value, 0.1)
    end prepareStart

    --WAIT FOR THE FIRST IMAGE IN CACHE
    on searchFor()
        log "Looking for images..."
        try
            tell application "Finder" to set waitingforFirstimage to (every file in Download1_folder)
            if (item 1 of waitingforFirstimage) exists then
                set meFinished to true
                log_event("Looking for images...Found!")
            end if
        end try
        
        if pauseUser = true then
            performSelector_withObject_afterDelay_("pauseSearch", missing value, 0.1)
            set pauseUser to false
        else if meFinished = true then
            performSelector_withObject_afterDelay_("Prepare", missing value, 1)
            set meFinished to false
        else
            performSelector_withObject_afterDelay_("SearchFor", missing value, 0.5)
        end if
    end searchFor
    
    --PREPARE FOR PROCESSING
    on Prepare()
        log_event("Preparing...")
        changeView_(me)
        enableArchive(false)
        tell MainBar1
            startAnimation_(me)
            setMaxValue_(4)
            setDoubleValue_(0)
            setIndeterminate_(false)
        end tell
        tell MainBar2
            startAnimation_(me)
            setMaxValue_(35)
            setDoubleValue_(0)
            setIndeterminate_(false)
        end tell
        tell MainDetail1 to setStringValue_("Preparing to Process Images...")
        tell MainDetail2 to setStringValue_("Total Progress...")
        set processNumber to 1
        set curNumber to processNumber
        
        performSelector_withObject_afterDelay_("determineNextImage", missing value, 1)
    end Prepare
    
    --DETERMINE THE NEXT IMAGE TO PROCESS
    on determineNextImage()
        log_event("Determining next image...")
        --If we pause and come back here we will throw off the image count
        --so when paused we resume at the next step (findNextImage)
        set lastTask to "findNextImage"
        --easy way to update finishedProcessing
        set finishedProcessing to false
        
        if processNumber = 1 then
            if reshootsel is "A" and processNumber is 1 then
                set imageNumber to 3
            else
                set imageNumber to processNumber
            end if
            set curDownloadFolder to Download1_folder
            set curBasename to "TopDown"
            set curDroplet to Droplet1Location
        end if
        if processNumber > 1 then
            set imageNumber to processNumber - 1
            set curDownloadFolder to Download2_folder
            set curBasename to "Hero"
            set curDroplet to Droplet2Location
        end if
        if processNumber = 18 then
            set imageNumber to processNumber - 16
            set curDownloadFolder to Download1_folder
            set curBasename to "TopDown"
            set curDroplet to Droplet1Location
        end if
        if processNumber > 18 then
            set imageNumber to processNumber - 18
            set curDownloadFolder to Download3_folder
            set curBasename to "Open"
            set curDroplet to Droplet3Location
        end if
        
        --Reshoot Processing Management
        if reshootsel = "A" and processNumber = 18 then
            --Stop processing once I finish all 17 images
            set meFinished to true
            set reshootSel to null
            --force finish on user window
            set processNumber to 35
            set imageNumber to "17"
            log_event("Finished Reshoot A!")
        else if reshootsel = "B" and processNumber = 35 then
            --Stop processing once I finish all 17 images
            --meFinished happens at end of processing above
            set reshootSel to null
            log_event("Finished Reshoot B!")
        end if
        
        --At the end of processing, Stop and enable the archive button
        if processNumber = 35 then
            enableArchive(true)
            set meFinished to true
        end if
        
        --Create next image name
        if processNumber < 35 then
            if imageNumber < 10 then set imageNumber to "0" & imageNumber as string
            set processImageName to "_" & curBasename & "_" & imageNumber & ".NEF" as string
        end if
        
        --Update the window
        tell MainBar2 to setDoubleValue_(processNumber)
        if processNumber < 35 then
            tell MainDetail2 to setStringValue_("Processing " & processNumber & " of 34")
        else
            tell MainDetail2 to setStringValue_("Finished!")
        end if
        
        --update the log
        if imageNumber = "17" then
            log_event("Image Processing done!")
        else
            log_event("Next Image: " & processImageName)
        end if
        
        --Although we're ready for the next processNumber, we need this number (curNumber) just
        --in case we don't find the next image yet and we need to know what image we just finished.
        set curNumber to processNumber
        --Next processNumber
        set processNumber to processNumber + 1
        
        if pauseUser = true then
            performSelector_withObject_afterDelay_("mainPause", missing value, Delay1)
            set pauseUser to false
        else if reqReshoot = true then
            performSelector_withObject_afterDelay_("ReshootNewProcess", missing value, Delay1)
            set reqReshoot to false
        else if meFinished = true then
            --End Processing
            set meFinished to false
            set finishedProcessing to true
        else
            --Always move on to the next step, never restart myself
            performSelector_withObject_afterDelay_("findNextImage", missing value, Delay1)
        end if
    end determineNextImage
    
    --WAIT FOR THE NEXT IMAGE TO ENTER THE FOLDER
    on findNextImage()
        set lastTask to "findNextImage"
        log "Waiting for image..."
        
        --Update the window
        tell MainBar1 to setDoubleValue_(1)
        tell MainDetail1 to setStringValue_("Looking for " & processImageName)
        
        try
            tell app "Finder" to set processImage to (every file in curDownloadFolder whose name contains processImageName)
            if (item 1 of processImage) exists then
                set processImage to item 1 of processImage
                --Update the curNumber because we've moved onto the next image
                set curNumber to processNumber
                set meFinished to true
                log_event("Image has arrived!")
                log_event("Waiting for image to download...")
            end if
        end try
        
        if pauseUser = true then
            performSelector_withObject_afterDelay_("mainPause", missing value, Delay1)
            set pauseUser to false
        else if reqReshoot = true then
            performSelector_withObject_afterDelay_("ReshootNewProcess", missing value, Delay1)
            set reqReshoot to false
        else if meFinished = true then
            performSelector_withObject_afterDelay_("waitForDownload", missing value, Delay1)
            set meFinished to false
        else
            performSelector_withObject_afterDelay_("findNextImage", missing value, Delay1)
        end if
    end fineNextImage
    
    --WAIT FOR THE NEXT IMAGE TO FINISH DOWNLOADING
    on waitForDownload()
        set lastTask to "waitForDownload"
        log "Waiting for download..."
        
        --Update the window
        tell MainBar1 to setDoubleValue_(2)
        tell MainDetail1 to setStringValue_("Waiting for " & processImageName & " to finish downloading...")
        
        try
            tell app "Finder" to set oldsize to physical size of processImage
            delay 0.1
            tell app "Finder" to set newsize to physical size of processImage
            if oldsize = newsize then
                log_event("Waiting for image to download...Done")
                log_event("Sending image to Photoshop...")
                --Send the image to photoshop using the correct droplet
                tell app "Finder" to open processImage using curDroplet
                set meFinished to true
                log_event("Waiting for droplet...")
            end if
        end try
        
        if pauseUser = true and meFinished = false then
            --"and meFinished = false" = If I finished, I don't want to resend the image to photoshop so we can't pause until the next step
            performSelector_withObject_afterDelay_("mainPause", missing value, Delay1)
            set pauseUser to false
        else if reqReshoot = true then
            performSelector_withObject_afterDelay_("ReshootNewProcess", missing value, Delay1)
            set reqReshoot to false
        else if meFinished = true then
            performSelector_withObject_afterDelay_("waitForDroplet", missing value, Delay1)
            set meFinished to false
        else
            performSelector_withObject_afterDelay_("waitForDownload", missing value, Delay1)
        end if
    end waitForDownload
    
    --WAIT FOR THE DROPLET TO SAVE THE IMAGE
    on waitForDroplet()
        set lastTask to "waitForDroplet"
        log "Waiting for droplet..."
        
        --Update the window
        tell MainBar1 to setDoubleValue_(3)
        tell MainDetail1 to setStringValue_("Processing " & processImageName)
        
        try
            set dropletTimeout to dropletTimeout + 1 
            tell app "Finder" to set processedContents to (every file in processedFolder) as text
            set strippedName to (text 1 thru ((offset of the "." in processImageName) - 1) in processImageName)
            if processedContents contains strippedName then
                set meFinished to true
                tell MainBar1 to setDoubleValue_(4)
                tell MainDetail1 to setStringValue_("Finished Processing " & processImageName)
                log_event("Waiting for Droplet...Done!")
            end if
        end try
        
        if pauseUser = true then
            performSelector_withObject_afterDelay_("mainPause", missing value, Delay1)
            set pauseUser to false
        else if reqReshoot = true then
            performSelector_withObject_afterDelay_("ReshootNewProcess", missing value, Delay1)
            set reqReshoot to false
        else if dropletTimeout = 40 then
            --if the timeout is met then ask the user to re-send the image to photoshop
            set dropletTimeout to 0
            delay 1
            areYouSure("The Processed image can not be found. " & return & "Resend last image to photoshop?","waitForDownload",lastTask)
        else if meFinished = true then
            performSelector_withObject_afterDelay_("determineNextImage", missing value, Delay1)
            set meFinished to false
            set dropletTimeout to 0
        else
            performSelector_withObject_afterDelay_("waitForDroplet", missing value, Delay1)
        end if
    end waitForDroplet
    
    --RESHOOT HANDLER MANAGING NEXT TASK
    on ReshootNewProcess()
        if reshootSel = "A" then
            log_event("Reshoot 'A' Selected...")
            set processNumber to 1
            reshootClearCache()
            performSelector_withObject_afterDelay_("determineNextImage", missing value, 1)
        else if reshootSel = "B" then
            log_event("Reshoot 'B' Selected...")
            set processNumber to 18
            reshootClearCache()
            performSelector_withObject_afterDelay_("determineNextImage", missing value, 1)
        else if reshootSel = "N" then
            log_event("Reshoot 'New' Selected...")
            delay 0.5
            performSelector_withObject_afterDelay_("StartClearCache", missing value, Delay1)
        end if
    end ReshootNewProcess
    
    --ENABLE OR DISABLE THE ARCHIVE BUTTON (TRUE/FALSE)
    on enableArchive(state)
        if state = true then
            tell ArchiveButton to setEnabled_(1)
        else
            tell ArchiveButton to setEnabled_(0)
        end if
    end enableArchive
    
    --IF RESHOOT "A" IS SELECTED
    on reshootA()
        set reshootSel to "A"
        set reqReshoot to true
        enableArchive(false)
        if isPaused is true or finishedProcessing is true then quietUserRequest()
    end reshootA
    
    --IF RESHOOT "B" IS SELECTED
    on reshootB()
        set reshootSel to "B"
        set reqReshoot to true
        enableArchive(false)
        if isPaused is true or finishedProcessing is true then quietUserRequest()
    end reshootB
    
    --IF RESHOOT "NEW" IS SELECTED
    on reshootNew()
        set reshootSel to "N"
        set reqReshoot to true
        enableArchive(false)
        if isPaused is true or finishedProcessing is true then quietUserRequest()
    end reshootNew
    
    --CLEAR THE CACHE DURING A "RESHOOT/NEW" FUNCTION
    on reshootClearCache()
        
        log_event("Reshoot Clear Cache...Reshoot" & reshootSel)
        showTempProgress("Preparing to Reshoot "& reshootSel & "...",4,1)
        
        if reshootSel = "A" then
            try
                --Delete the download1 file for A
                tell app "Finder" to set theImage to (every file in Download1_folder whose name contains "_TopDown_01.NEF")
                tell app "Finder" to set theImage to item 1 of theImage as alias
                do shell script "rm -rf " & POSIX path of theImage
                tell tempBar1 to incrementBy_(1)
                tell tempDetail1 to setStringValue_("Removing old data from Download1...")
                --Delete everything in download2
                do shell script "rm -rf " & POSIX path of (RoundHouseHelper_folder & "Download2:*" as string)
                tell tempBar1 to incrementBy_(1)
                tell tempDetail1 to setStringValue_("Removing old data from Download2...")
                --Find all of the images in the processed folder
                tell app "Finder" to set processedImages to (every file in processedFolder whose name contains "_Hero_")
                tell tempDetail1 to setStringValue_("Removing old data from processed...")
                repeat with i in processedImages
                    do shell script "rm -rf " & POSIX path of (i as alias)
                end repeat
                tell app "Finder" to set processedImages to (every file in processedFolder whose name contains "_TopDown_01")
                do shell script "rm -rf " & POSIX path of (item 1 of processedImages as alias)
                --Done!
                tell tempBar1 to incrementBy_(1)
                tell tempDetail1 to setStringValue_("Ready to Reshoot A!")
                log_event("Reshoot Clear Cache...Done!")
            on error errmsg
                log_event("Reshoot Clear Cache...FAILED")
                display dialog "Error when Clearing the Cache for Reshoot. Please Close & re-open RoundHouseHelper." buttons ("Ok") default button 1 with icon (stop) 
            end try
        else if reshootSel = "B" then
            try
                --Delete the download1 file for B
                tell app "Finder" to set theImage to (every file in Download1_folder whose name contains "_TopDown_02.NEF")
                tell app "Finder" to set theImage to item 1 of theImage as alias
                do shell script "rm -rf " & POSIX path of theImage
                tell tempBar1 to incrementBy_(1)
                tell tempDetail1 to setStringValue_("Removing old data from Download1...")
                --Delete everything in download3
                do shell script "rm -rf " & POSIX path of (RoundHouseHelper_folder & "Download3:*" as string)
                tell tempBar1 to incrementBy_(1)
                tell tempDetail1 to setStringValue_("Removing old data from Download3...")
                --Find all of the images in the processed folder
                tell app "Finder" to set processedImages to (every file in processedFolder whose name contains "_Open_")
                tell tempDetail1 to setStringValue_("Removing old data from processed...")
                repeat with i in processedImages
                    do shell script "rm -rf " & POSIX path of (i as alias)
                end repeat
                tell app "Finder" to set processedImages to (every file in processedFolder whose name contains "_TopDown_02")
                do shell script "rm -rf " & POSIX path of (item 1 of processedImages as alias)
                --Done!
                tell tempBar1 to incrementBy_(1)
                tell tempDetail1 to setStringValue_("Ready to Reshoot B!")
                log_event("Reshoot Clear Cache...Done!")
            on error errmsg
                log_event("Reshoot Clear Cache...FAILED")
                display dialog "Error when Clearing the Cache for Reshoot. Please Close & re-open RoundHouseHelper." buttons ("Ok") default button 1 with icon (stop)
            end try
        end if
        --Hide the progress window
        delay 0.75
        hideTempProgress()
    end reshootClearCache
    
    --PAUSE THE MAIN PROCESSING
    on mainPause()
        tell MainBar1 to stopAnimation_(me)
        tell MainBar2 to stopAnimation_(me)
        set isPaused to true
        log_event("Main Processing Paused!")
    end mainPause
    
    --RESUME THE MAIN PROCESSING
    on mainResume()
        tell mainPauseButton to setState_(0)
        tell MainBar1 to startAnimation_(me)
        tell MainBar2 to startAnimation_(me)
        set isPaused to false
        log_event("Main Processing Resumed!")
        performSelector_withObject_afterDelay_(lastTask, missing value, delay1)
    end mainResume
    
    --Enable user requests even when processing is paused or finished.
    on quietUserRequest()
        if reqReshoot = true then
            performSelector_withObject_afterDelay_("ReshootNewProcess", missing value, Delay1)
            set reqReshoot to false
        end if
        if isPaused is true then tell mainPauseButton to setState_(0)
        log_event("Quiet user Resume...")
    end quietUserRequest
    
    (* ======================================================================
                                Handlers for Archiving!
     ====================================================================== *)
    
    --START ARCHIVING
    on startArchive()
        --disable the archive button
        enableArchive(false)
        
        set curTempMaxValue to 89
        log_event("Archiving...")
        log_event("Archiving...Preparing")
        
        --set overwrite to false
        set overwrite to false
        log_event("Archiving...Reset Overwrite status")
        
        showTempProgress("Preparing to archive current take...",curTempMaxValue,0)
        performSelector_withObject_afterDelay_("updateProgressD4", missing value, 0.01)
    end startArchive
    
    --UPDATE THE MAXVALUE OF THE PROGRESS BAR WITH NUMBER OF IMAGES IN DOWNLOAD4
    on updateProgressD4()
        --Update the maxvalue depending on number of download 4 images
        log_event("Archiving...Updating MaxValue with Download4")
        try
            tell app "Finder" to set thecontents to every file of Download4FinalFolder
            --get the number of items
            set countofitems to (count of items in thecontents)
            --update the max value on the bar
            tell tempBar1 to setMaxValue_(curTempMaxValue + (countofitems * 2) as integer)
            log_event("Archiving..." & countofitems & " Download4 images found")
        on error errmsg
            log_event("Archiving...No Download4 images found")
        end try
        performSelector_withObject_afterDelay_("getFilenameCheckExists", missing value, 0.01)
    end updateProgressD4
    
    --CANCEL ARCHIVE
    on cancelArchive()
        log_event("Archiving...Canceled")
        doneArchive()
    end cancelArchive
    
    --GET THE CARNUMBER AND CHECK IF IT ALREADY EXISTS
    on getFilenameCheckExists()
        
        --Get the car Number (only if it isn't already set)
        if carNumber = null or  NumberChanged is false then
            try
                log_event("Archiving...Get Car Number")
                tempProgressUpdate(1,"Getting car Number...")
                tell application "Finder" to set fullname to name of ((first item of Download1_folder) as alias)
                set carNumber to (text 1 thru ((offset of "_" in fullname) - 1) of fullname) as string
            on error errmsg
                hideTempProgress()
                delay 0.1
                log_event("Archiving FAILED - Could not get car number")
                display dialog "Could not get CarNumber. Files are either missing or improperly named." buttons ("Ok") default button 1 with icon (stop)
                return
            end try
        end if
        log_event("Archiving...carNumber: " & carNumber)
        
        --Check if files already exist
            log_event("Archiving...Check if Images already exist")
            tempProgressUpdate(1,"Checking if files already exists in save locations...")
        try
            tell application "Finder" to set Completed_folder_contents to (entire contents of ((saveFolderloc & carNumber & ":" as string) as alias) as text)
            if Completed_folder_contents contains "-edc-" or Completed_folder_contents contains "-edo-" or Completed_folder_contents contains "-top-" or Completed_folder_contents contains "-manual-" then set files_exist to true
        end try
        try
            tell application "Finder" to set zip_folder_contents to (entire contents of (rawFolderloc as alias) as text)
            if zip_folder_contents contains (carNumber & ".zip" as string) then set files_exist to true
        end try
        
        --if files exists ask the user, else continue archiving
        if files_exist is true and NumberChanged is true then
            log_event("Archiving...images exist")
            log_event("Archiving...Number already changed, ask to overwrite")
            set files_exist to false
            set NumberChanged to false
            hideTempProgress()
            delay 0.3
            areYouSure(carNumber & " exists. overwrite anyways?","OverwriteResume","startArchive")
        else if files_exist is true then
            log_event("Archiving...images exist")
            set files_exist to false
            hideTempProgress()
            delay 0.3
            showFilesExistWindow()
        else
            log_event("Archiving...images do not exist")
            performSelector_withObject_afterDelay_("prepareImagesForArchive", missing value, 0.01)
        end if
    end getFilenameCheckExists
    
    --PREPARE THE IMAGES IN THE PROCESSED FOLDER
    on prepareImagesForArchive()
        log_event("Archiving...Prepare images in cache for archive")
        
        tell app "Finder" to set theProcessedImages to every file of processedFolder
        
        log_event("Archiving...Duplicate-Rename-Resize started")
        repeat with api in theProcessedImages
            log_event("Archiving...Gather information about: " & api as string)
            tell application "Finder"
                --Get the name of the file
                set original_name to name of api as string
                --get the extention of the file
                set api_extention to name extension of api as string
            end tell
            --Get the basename
            set original_name_basename to (text 1 thru ((offset of ("." & api_extention as string) in original_name) - 1) of original_name) as string
            --Get the filenumber (different from carnumber)
            set api_filenumber to (text ((offset of ("." & api_extention as string) in original_name) - 2) thru ((offset of ("." & api_extention as string) in original_name) - 1) of original_name) as string
            --Get the camera identifier (aka "Topdown")
            set api_classification to (text ((offset of "_" in original_name) + 1) thru ((offset of ("_" & api_filenumber as string) in original_name) - 1) of original_name) as string
            if api_classification = "Hero" then
                set api_detail to "edc"
            else if api_classification = "TopDown" then
                set api_detail to "top"
            else if api_classification = "Open" then
                set api_detail to "edo"
            else
                --If I can't determine the name then cancel the sheet
                log_event("Archiving...Can't determine the classification of processed image: " & original_name)
                cancelArchive()
                return
            end if
            --Update the progress window & short pause so we can see the update
            tempProgressUpdate(1,"Preparing " & (carNumber & "-" & api_detail & "-" & api_filenumber & ".UPLOADLARGE." & api_extention as string) & "...")
            delay 0.05
            log_event("Archiving...duplicate and rename files")
            --Now that we have all of the information about this image
            --Lets create a duplicate file with the "small" file name
            do shell script "cp " & POSIX path of (api as alias) & " " & POSIX path of (processedFolder & carNumber & "-" & api_detail & "-" & api_filenumber & ".UPLOADSMALL." & api_extention as string)
            --now lets rename the original file to the "large" name
            do shell script "mv " & POSIX path of (api as alias) & " " & POSIX path of (processedFolder & carNumber & "-" & api_detail & "-" & api_filenumber & ".UPLOADLARGE." & api_extention as string)
            --Update the progress window & short pause so we can see the update
            tempProgressUpdate(1,"Resizing " & (carNumber & "-" & api_detail & "-" & api_filenumber & ".UPLOADSMALL." & api_extention as string) & "...")
            delay 0.05
            log_event("Archiving...resize 'small' image")
            --Now lets resize the "small" image using image events
            tell application "Image Events"
                launch
                set api_duplicate to (processedFolder & carNumber & "-" & api_detail & "-" & api_filenumber & ".UPLOADSMALL." & api_extention as string) as alias
                set this_image to open api_duplicate
                scale this_image to size 940
                save this_image with icon
                close this_image
            end tell
        end repeat
        log_event("Archiving...Duplicate-Rename-Resize finished")
        
        performSelector_withObject_afterDelay_("checkdownload4", missing value, 0.01)
    end prepareImagesForArchive
    
    --CHECK DOWNLOAD 4 - RENAME AND MOVE TO PROCESSED FOLDER
    on checkdownload4()
        
        --try to get the contents of the folder
        log_event("Archiving...Checking for download4 files")
        try
            tell app "Finder"
                set thecontents to every file of Download4FinalFolder
                set firstfile to (first item of Download4FinalFolder) as alias
            end tell
            set D4exists to true
            log_event("Archiving...download4 files exist!")
        on error errmsg
            log_event("Archiving...download4 files do not exist")
        end try
        
        --if they exists rename & move them to the processed folder
        if D4exists = true then
            set api_filenumber to 0
            log_event("Archiving...Processing download4 files")
            
            --rename the files
            repeat with api in thecontents
                log_event("Archiving...Gather information about: " & api as string)
                --set file number
                set api_filenumber to api_filenumber + 1
                if api_filenumber < 10 then set api_filenumber to  ("0" & api_filenumber as string)
                --rename the files
                tell application "Finder"
                    --Get the name of the file
                    set original_name to name of api as string
                    --get the extention of the file
                    set api_extention to name extension of api as string
                end tell
                tempProgressUpdate(1,"Resizing " & (carNumber & "-manual-" & api_filenumber & ".UPLOADMANUAL." & api_extention as string) & "...")
                delay 0.05
                log_event("Archiving...resize file")
                --resize the image
                tell application "Image Events"
                    launch
                    set this_image to open api as alias
                    scale this_image to size 2802
                    save this_image with icon
                    close this_image
                end tell
                --Rename the file
                tempProgressUpdate(1,"Rename " & (carNumber & "-manual-" & api_filenumber & ".UPLOADMANUAL." & api_extention as string) & "...")
                delay 0.05
                log_event("Archiving...rename file")
                --rename the file
                do shell script "mv " & POSIX path of (api as alias) & " " & POSIX path of (Download4FinalFolder & carNumber & "-manual-" & api_filenumber & ".UPLOADMANUAL." & api_extention as string)
            end repeat
        log_event("Archiving...Download4 files finished")
        end if
        
        performSelector_withObject_afterDelay_("organizeData", missing value, 0.01)
    end checkdownload4
    
    --PREPARE DATA AND COPY THE FILES TO THE SAVED FOLDER
    on organizeData()
        log_event("Archiving...Organize Data")
        
        --move images from each download folder to the prearchive folder
        do shell script "mv " & POSIX path of (RoundHouseHelper_folder & "Download1:*" as string) & " " & POSIX path of prearchiveFolder
        log_event("Archiving...move images from Download1 to Prearchive")
        tempProgressUpdate(1,"Move Download1 images to Prearchive Folder...")
        delay 0.05
        do shell script "mv " & POSIX path of (RoundHouseHelper_folder & "Download2:*" as string) & " " & POSIX path of prearchiveFolder
        log_event("Archiving...move images from Download2 to Prearchive")
        tempProgressUpdate(1,"Move Download2 images to Prearchive Folder...")
        delay 0.05
        do shell script "mv " & POSIX path of (RoundHouseHelper_folder & "Download3:*" as string) & " " & POSIX path of prearchiveFolder
        log_event("Archiving...move images from Download3 to Prearchive")
        tempProgressUpdate(1,"Move Download3 images to Prearchive Folder...")
        delay 0.05
        
        --remove any "manual" images if overwrite is true
        log_event("Archiving...Remove any previous MANUALUPLOAD images")
        tempProgressUpdate(1,"Remove any previous MANUALUPLOAD images...")
        delay 0.05
        try
            if overwrite is true then do shell script "rm -r " & POSIX path of (saveFolderloc & carNumber & ":Manual:" as string)
        end try
        
        --Try to create the car folder
        tempProgressUpdate(1,"Manage save folders in save location...")
        delay 0.05
        try
            tell app "Finder" to make new folder at (saveFolderloc as alias) with properties {name:carNumber as string}
            log_event("Archiving...Car Folder created")
        on error errmsg
            log_event("Archiving...Car Folder already exists")
        end try
        
        --try to create the Manual folder
        try
            if D4exists is true then
                tell app "Finder" to make new folder at ((saveFolderloc & carNumber & ":" as string) as alias) with properties {name:"Manual"}
                log_event("Archiving...Maunal Folder created")
            else
                log_event("Archiving...No Images - Maunal Folder not created")
            end if
        on error errmsg
            log_event("Archiving...Maunal Folder already exists")
        end try
        
        --get saved folder contents for overwrite/error
        try
            tell app "Finder" to set savedFolderContents to every file of ((saveFolderloc & carNumber as string) as alias)
        end try
        try
            tell app "Finder" to set manualFolderContents to every file of ((saveFolderloc & carNumber & ":Manual:" as string) as alias)
        end try
        
        --if overwrite is true then recite contents of folders before overwrite
        if overwrite is true then
            log_event("Archiving...Overwite is true")
            try
                if item 1 of savedFolderContents exists then reciteFolderContents(savedFolderContents,"SAVE FOLDER CONTENTS")
            end try
            try
                if item 1 of manualFolderContents exists then reciteFolderContents(manualFolderContents,"MANUAL FOLDER CONTENTS")
            end try
        end if
        
        --Copy the new files over (overwrite automatically)
        log_event("Archiving...Copy files from Processed folder to savefolder with ID: " & carNumber)
        tempProgressUpdate(1,"Copying processed images to save folder: " & carNumber)
        
        try
            do shell script "cp " & POSIX path of (RoundHouseHelper_folder & "Processed:*" as string) & " " & POSIX path of (saveFolderloc & carNumber as string)
        on error errmsg
            log_event("Archiving...FAILED TO MOVE FINAL IMAGES TO SAVED FOLDER")
            set saved to false
            log_event("Archiving...Archiving Values Reset")
            --if overwrite it false then recite the old contents of the saved folder
            if overwrite is false then
                try
                    if item 1 of savedFolderContents exists then reciteFolderContents(savedFolderContents,"OLD SAVE FOLDER CONTENTS")
                end try
            end if
            --recite the new contents of the saved folder
            try
                tell app "Finder" to set savedFolderContents to every file of ((saveFolderloc & carNumber as string) as alias)
                reciteFolderContents(savedFolderContents,"NEW SAVE FOLDER CONTENTS")
            end try
        end try
        
        if D4exists is true then
            log_event("Archiving...Copy files to  manual folder")
            try
                do shell script "cp " & POSIX path of (RoundHouseHelper_folder & "Download4Final:*" as string) & " " & POSIX path of (saveFolderloc & carNumber & ":Manual:" as string)
            on error errmsg
                log_event("Archiving...FAILED TO MOVE MANUAL IMAGES TO MANUAL FOLDER")
                set saved to false
                log_event("State...Saved set to false")
                --if overwrite it false then recite the old contents of the maunal folder
                if overwrite is false then
                    try
                        if item 1 of manualFolderContents exists then reciteFolderContents(manualFolderContents,"OLD MANUAL FOLDER CONTENTS")
                    end try
                end if
                --recite the new contents of the manual folder
                try
                    tell app "Finder" to set manualFolderContents to every file of ((saveFolderloc & carNumber & ":Manual:" as string) as alias)
                    reciteFolderContents(manualFolderContents,"NEW MANUAL FOLDER CONTENTS")
                end try
            end try
        end if
        
        log_event("Archiving...Organize Data Finished")
        performSelector_withObject_afterDelay_("doArchive", missing value, 0.01)
    end organizeData
    
    --ZIP THE PREARCHIVE CONTENTS
    on doArchive()
        log_event("Archiving...Prepare to zip Prearchive folder")
        
        --try to remove old data if it exists
        tempProgressUpdate(1,"If old data exists, remove it...")
        delay 0.05
        try
            do shell script "rm -rf " & quoted form of POSIX path of (saveFolderloc & carNumber & ".zip" as string)
            log_event("Archiving...old zip file removed")
        on error errsmg
            log_event("Archiving...FAILED TO CREATE ARCHIVE OF RAW IMAGES")
        end try
        
        --Set the zip path
        log_event("Archiving...Create the zip file")
        tempProgressUpdate(1,"Archiving Raw Images (zip)...Please wait")
        set zippath to rawFolderloc & carNumber & ".zip" as string
        delay 0.25
        
        --create the zip file!
        try
            do shell script "zip -r -jr " & quoted form of POSIX path of zippath & " " & quoted form of POSIX path of prearchiveFolder
        on error errmsg
            log_event("Archiving...FAILED WHILE ATTEMPTING TO CREATE ZIP FILE")
            set saved to false
            log_event("State...Saved set to false")
            tell me to display dialog "Failed to create .zip of raw images! Please close and re-open the Helper." buttons ("Ok") default button 1 with icon (stop)
        end try
        
        --Done archiving
        performSelector_withObject_afterDelay_("doneArchive", missing value, 0.01)
    end doArchive
    
    --FINISHED!
    on doneArchive()
        enableArchive(false)
        set carNumber to null
        set overwrite to false
        set D4exists to false
        set NumberChanged to false
        tempProgressUpdate(10,"Finished Archiving.")
        delay 1
        hideTempProgress()
        --Log the status of the saved state
        log_event("State...Saved is currently " & saved as text)
        --if the zip saved sucessfully then clear the cache, otherwise let the user try again
        if saved is true then
            log_event("Display dialog...Archiving Complete!")
            try
                display dialog "Archiving Complete!" buttons ("Ok") default button 1 with icon (1)
            end try
        else
            log_event("Display dialog...The image failed to save properly. Please restart.")
            try
                display dialog "The image failed to save properly. Please restart." buttons ("Ok") default button 1 with icon (stop)
            end try
        end if
        --reset saved for next use
        set saved to true
        log_event("State...Saved reset to true")
        --clear the cache regaurdless of saved state
        performSelector_withObject_afterDelay_("StartClearCache", missing value, 1)
        log_event("Archiving...Done!")
    end doneArchive
    
    
    (* ======================================================================
                    Default "Application will..." Handlers
     ====================================================================== *)
    
    on applicationWillFinishLaunching_(aNotification)
        
        log_event("==========PROGRAM INITILIZE=========")
        --check the log and backup if over max line count (30,000)
        checklog()
        --Routine Check Cache folders
        checkCacheFolders_(me)
        --Check for Droplets
        checkDroplets_(me)
        --Set/Get Preferences
        tell current application's NSUserDefaults to set defaults to standardUserDefaults()
        tell defaults to registerDefaults_({saveFolderloc:((path to desktop)as string),rawFolderloc:((path to desktop)as string)})
        retrieveDefaults_(me)
        --set curView
        set curView to MainView
        --Start at correct View
        changeView_(me)
                
        --initializing turned to false after applicationWillFinishLaunching
        set initializing to false
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
        log_event("==========PROGRAM SHUTDOWN==========")
		return current application's NSTerminateNow
	end applicationShouldTerminate_
    
    (* ======================================================================
                   Background Handlers for window/view control
     ====================================================================== *)
    
    -- View changing handler for multiple view changes.
    on changeView_(sender)
		-- get frame of replacement view
		if curView = MainView then
			set theFrame to SearchView's frame()
            set curView to SearchView
            log_event("Change View to Search Window")
        else
			set theFrame to MainView's frame()
            set curView to MainView
            log_event("Change View to Main Window")
		end if
		tell MainWindow
			-- get frame required for window
			set theFrame to frameRectForContentRect_(theFrame)
			-- get individual values for the new view and the window
			set {origin:{x:frameX, y:frameY}, |size|:{|width|:frameWidth, height:frameHeight}} to theFrame
			set {origin:{x:windowX, y:windowY}, |size|:{|width|:windowWidth, height:windowHeight}} to frame()
			-- calculate new frame
			set newOrigin to {x:windowX - (frameWidth - windowWidth) / 2, y:windowY - frameHeight + windowHeight}
			set newFrame to {origin:newOrigin, |size|:{|width|:frameWidth, height:frameHeight}}
			set newFrame to my adjustFrame_forScreenOfWindow_(newFrame, MainWindow)
			-- put in blank view
			setContentView_(blankView)
			-- resize window
			setFrame_display_animate_(newFrame, true, true)
			-- put in the replacement view
			if curView = SearchView then
				setContentView_(SearchView)
            else
				setContentView_(MainView)
			end if
		end tell
        log_event("Change View Sucessful!")
	end changeView_
	
	on adjustFrame_forScreenOfWindow_(proposedFrame, aWindow)
		set {origin:{x:windowX, y:windowY}, |size|:{|width|:windowWidth, height:windowHeight}} to proposedFrame
		set screenFrame to aWindow's screen()'s visibleFrame()
		set {origin:{x:frameX, y:frameY}, |size|:{|width|:frameWidth, height:frameHeight}} to screenFrame
		-- check left
		if windowX < frameX then set windowX to frameX
		--check right
		if windowX + windowWidth > frameX + frameWidth then set windowX to frameX + frameWidth - windowWidth
		-- check bottom
		if windowY < frameY then set windowY to frameY
		return {origin:{x:windowX, y:windowY}, |size|:{|width|:windowWidth, height:windowHeight}}
	end adjustFrame_forScreenOfWindow_
    
    on StartClearCacheButton_(sender)
        --Use MyriadHelpers to show cache window as sheet
        log_event("Clear Cache...")
        tell CacheWindow to showOver_(MainWindow)
        clearCache()
    end StartClearCacheButton_
    
    on StartClearCache()
        StartClearCacheButton_(me)
    end StartClearCache
    
    on CancelClearCacheButton_(sender)
        --Use MyriadHelpers to close cache sheet
        set cancelCache to true
	end ClearCacheCancelButton_
    
    on PauseClearCacheButton_(sender)
        --Pause the Clear Cache
        if pauseCache = false then
            log_event("Clear Cache...Paused")
            set pauseCache to true
        else
            log_event("Clear Cache...Resumed")
            set pauseCache to false
        end if
	end PauseCacheCancelButton_
    
    on OpenPreferences_(sender)
        --open preferences window
        log_event("Open Preferences...")
        updateSavefolderLocLabel()
        updateRawfolderLocLabel()
        PreferencesWindow's makeKeyAndOrderFront_(me)
        log_event("Open Preferences...Finished")
    end OpenPreferences_
    
    on ReshootNew_(sender)
        --Open reshoot/New Window
        log_event("Reshoot-New window opened")
        
        --Enable "Reshoot" buttons during breaks.
        if curNumber = 35 then
            tell aReshootNew to setEnabled_(1)
            tell bReshootNew to setEnabled_(1)
        end if
        
        tell ReshootWindow to showOver_(MainWindow)
    end ReshootNew_
    
    on closeReshootNew_(sender)
        --Use MyriadHelpers to close cache sheet
        tell current application's NSApp to endSheet_(ReshootWindow)
        tell aReshootNew to setEnabled_(0)
        tell bReshootNew to setEnabled_(0)
        if cancelReshootNew = true then
            log_event("Reshoot-New window closed")
            set cancelReshootNew to false
        end if
	end closeReshootNew_
    
    on ReshootAButton_(sender)
        closeReshootNew_(me)
        areYouSure("Are you sure you want to Reshoot A?","reshootA",null)
    end ReshootAButton_
        
    on ReshootBButton_(sender)
        closeReshootNew_(me)
        areYouSure("Are you sure you want to Reshoot B?","reshootB",null)
    end ReshootBButton_
        
    on NewButton_(sender)
        closeReshootNew_(me)
        areYouSure("Are you sure you want to start over?","reshootNew",null)
    end NewButton_
    
    on cancelReshootNewButton_(sender)
        set cancelReshootNew to true
        closeReshootNew_(me)
    end cancelReshootNewButton_

    on searchButton_(sender)
        log_event("Search Button selected....")
        --Figure out what state the button is in
        if title of sender as string is "Start" then
            --Make sure the droplets exist
            checkDroplets_(me)
            if droplet1exist of dropletsExist = false or droplet2exist of dropletsExist = false or droplet3exist of dropletsExist = false then
                log_event("Droplet Missing!")
                tell searchButton1 to setState_(0)
                display dialog "CAN NOT START: MISSING A DROPLET." &  "Load new droplets in the Preferences window." buttons ("Ok") default button 1 with icon (stop)
                return
            end if
            --If we still haven't started, clear cache then start searching
            tell searchButton1 to setState_(0)
            StartClearCacheButton_(me)
        else if title of sender as string = "Pause" and state of sender as string = "1" then
            --If we started then, pause the search
            set pauseUser to true
            log_event("User Request... Pause")
        else if state of sender as string = "0" then
            --If we're paused, resume searching
            resumeSearch()
        end if
    end searchButton
    
    on resetForStart()
        tell searchDetail1 to setStringValue_("Press Start")
        tell searchButton1 to setTitle_("Start")
        tell searchBar1 to stopAnimation_(me)
        if curView = MainView then changeView_(me)
    end resetForStart
    
    on pauseSearch()
        tell searchDetail1 to setStringValue_("Paused")
        tell searchBar1 to stopAnimation_(me)
        log_event("Paused by User...")
    end pauseSearch
    
    on resumeSearch()
        tell searchDetail1 to setStringValue_("Looking for images...")
        tell searchBar1 to startAnimation_(me)
        log_event("Resumed by User...")
        searchFor()
    end resumeSearch
    
    on startSearch()
        tell searchDetail1 to setStringValue_("Looking for images...")
        tell searchButton1 to setTitle_("Pause")
        tell searchBar1 to startAnimation_(me)
        log_event("Search Start...")
        log_event("Looking for images...")
        searchFor()
    end startSearch
    
    on nextStep_(sender)
        set meFinished to true
    end nextStep_
    
    on quickCache_(sender)
        if cacheWait is not 0.01 then
            log "cacheWait = 0.01"
            set cacheWait to 0.01
        else
            log "cacheWait = 1"
            set cacheWait to 1
        end if
    end quickCache_
    
    on areYouSure(message,yesHandler,noHandler)
        tell doubleCheckLabel to setStringValue_(message)
        set doubleCheckYesHandler to yesHandler
        set doubleCheckNoHandler to noHandler
        tell doubleCheckWindow to showOver_(MainWindow)
        log_event("Are you sure..." & message)
    end areYouSure
    
    on doubleCheckYes_(sender)
        tell current application's NSApp to endSheet_(doubleCheckWindow)
        if doubleCheckYesHandler is not null then
            performSelector_withObject_afterDelay_(doubleCheckYesHandler, missing value, 1)
        end if
        log_event("Are you sure...Yes")
        set doubleCheckYesHandler to null
    end doubleCheckYes_
    
    on doubleCheckNo_(sender)
        tell current application's NSApp to endSheet_(doubleCheckWindow)
        if doubleCheckNoHandler is not null then
            performSelector_withObject_afterDelay_(doubleCheckNoHandler, missing value, 1)
        end if
        log_event("Are you sure...No")
        set doubleCheckNoHandler to null
    end doubleCheckNo_
    
    on mainPauseProcessing_(sender)
        if state of sender as string = "1" then
            --Pause everything (request)
            set pauseUser to true
            log_event("User Request... Pause")
        else if state of sender as string = "0" then
            --Resume Processing
            mainResume()
        end if
    end mainPauseProcessing_
    
    on showTempProgress(tempDetail,tempMaxValue,tempValue)
        log_event("Show Temp Progress...")
        log_event("Show Temp Progress...Detail: " & tempDetail)
        log_event("Show Temp Progress...maxValue: " & tempMaxValue & " curValue: " & tempValue)
        tell tempDetail1 to setStringValue_(tempDetail)
        tell tempBar1 to setMaxValue_(tempMaxValue)
        tell tempBar1 to setDoubleValue_(tempValue)
        tell tempWindow to showOver_(MainWindow)
        log_event("Show Temp Progress..opened")
    end showTempProgress
    
    on hideTempProgress()
        log_event("Show Temp Progress..closed")
        tell current application's NSApp to endSheet_(tempWindow)
    end hideTempProgress
    
    on tempProgressUpdate(x,message)
        if x doesn't equal null then
            tell tempBar1 to incrementBy_(x)
        end if
        if message doesn't equal null then
            tell tempDetail1 to setStringValue_(message)
        end if
    end tempProgressUpdate
    
    on archiveButtonPress_(sender)
        areYouSure("Are you sure you want to Archive?","startArchive",null)
    end archiveButtonPress_
    
    on showFilesExistWindow()
        log_event("Car Number exists...")
        set existsNumber to carNumber as string
        tell existsTextField to setStringValue_(carNumber)
        tell existsWindow to showOver_(MainWindow)
        log_event("Car Number exists...opened")
    end showFilesExistWindow
    
    on forceShowFilesExistWindow_(sender)
        set carNumber to "10000000001"
        showFilesExistWindow()
    end forceShowFilesExistWindow_
    
    on closeFilesExistWindow()
        tell current application's NSApp to endSheet_(existsWindow)
        log_event("Car Number exists...closed")
    end closeFilesExistWindow
    
    on cancelFilesExist_(sender)
        log_event("Car Number exists...user canceled")
        closeFilesExistWindow()
        enableArchive(true)
    end calcelFilesExist_
    
    on continueFilesExist_(sender)
        log_event("Car Number exists...user continue")
        --Check what the user indicated to do via radio buttons
        if existsSelection as string = "Overwrite" then
            log_event("Car Number exists...Overwrite")
            --move on to next step and overwrite
            closeFilesExistWindow()
            delay 0.3
            --ask the user if they are sure
            areYouSure("Are you sure you wish to overwrite " & carNumber & "?","OverwriteResume","startArchive")
        else
            --if the number didn't change let the user know and don't do anything
            if existsNumber = carNumber then
                display dialog "To archive with a different file number, you must change the file number in the text field" buttons ("Ok") default button 1 with icon (2)
                return
            end if
            --change the car number
            log_event("Car Number exists...Change number to " & existsNumber as string)
            set carNumber to existsNumber as string
            set NumberChanged to true
            --Try again with new car number
            closeFilesExistWindow()
            delay 0.3
            performSelector_withObject_afterDelay_("startArchive", missing value, 0.01)
        end if
    end continueFilesExist_
    
    on toggleExistsTextField_(sender)
        if existsSelection as text is "Change the number to:" then
            tell existsTextField to setEnabled_(1)
        else
            tell existsTextField to setEnabled_(0)
        end if
    end toggleExists_
    
    on OverwriteResume()
        tell tempWindow to showOver_(MainWindow)
        set overwrite to true
        log_event("Archiving...Overwrite is true")
        performSelector_withObject_afterDelay_("prepareImagesForArchive", missing value, 0.3)
    end OverwriteResume
    
    on forceFilesExist_(sender)
        if files_exist = false then
            log "files_exist = true"
            set files_exist to true
        else if files_exist = true then
            log "files_exist = false"
            set files_exist to false
        end if
    end forceFilesExist_
    
    on forceFinishProcess_(sender)
        set processNumber to 35
    end forceFinishProcess_
    
    on forceDoneArchive_(sender)
        doneArchive()
    end forceDoneArchive_

    
    (* ======================================================================
                        Handlers for startup & shutdown!
     ====================================================================== *)
    
    --CHECK FOR CACHE FOLDERS
    on checkCacheFolders_(sender)
        log_event("Checking for Cache Folders...")
        set CacheFolderList to {"Download1", "Download2", "Download3", "Download4", "Download4Final", "Processed", "Prearchive", "Droplets"}
        set CacheFolderLoc to ((path to library folder) & "Caches:" as string) as alias
        
        --Roundhousehelper cache folder
        try
            tell application "Finder" to make new folder at CacheFolderLoc with properties {name:"RoundHouseHelper"}
            log_event("Cache Folder 'RoundHouseHelper' created at... " & CacheFolderLoc as string)
        end try
        set RoundHouseHelper_folder to (path to library folder) & "Caches:RoundHouseHelper:" as string
        
        --create each folder from the list
        repeat with aFolder in CacheFolderList
            try
                tell application "Finder" to make new folder at (RoundHouseHelper_folder as alias) with properties {name:aFolder}
                log_event("Cache Folder '" & (aFolder as string) & "' created at... " & RoundHouseHelper_folder as string)
            end try
        end repeat
        
        --set cache folder aliases
        set Download1_folder to (RoundHouseHelper_folder & "Download1:" as string) as alias
        set Download2_folder to (RoundHouseHelper_folder & "Download2:" as string) as alias
        set Download3_folder to (RoundHouseHelper_folder & "Download3:" as string) as alias
        set Download4_folder to (RoundHouseHelper_folder & "Download4:" as string) as alias
        set processedFolder to (RoundHouseHelper_folder & "Processed:" as string) as alias
        set prearchiveFolder to (RoundHouseHelper_folder & "Prearchive:" as string) as alias
        set Download4FinalFolder to (RoundHouseHelper_folder & "Download4Final:" as string) as alias
        set dropletFolder to (RoundHouseHelper_folder & "Droplets:" as string)
        log_event("Checking for Cache Folders...Finished")
    end checkCacheFolders_
    
    --CHECK FOR DROPLETS
    on checkDroplets_(sender)
        log_event("Checking for Droplets...")
        --set defaults
        set dropletsExist to {droplet1exist:false,droplet2exist:false,droplet3exist:false}
        --gets contents of droplets folder
        try
            set dropFolderCont to null
            tell Application "Finder" to set dropFolderCont to every file in (dropletFolder as alias) as string
        end try
        --update droplets exists if droplets are found
        if dropFolderCont as text contains drop1Name then
            set droplet1exist of dropletsExist to true
            set Droplet1Location to (dropletFolder & drop1Name & ".app" as string) as alias
            if initializing is true then log_event("Found " & drop1Name as string)
            tell drop1Indicator to setIntValue_(1)
        else
            set droplet1exist of dropletsExist to false
            if initializing is true then log_event("MISSING DROPLET " & drop1Name as string)
            tell drop1Indicator to setIntValue_(3)
        end if
        if dropFolderCont as text contains drop2Name then
            set droplet2exist of dropletsExist to true
            set Droplet2Location to (dropletFolder & drop2Name & ".app" as string) as alias
            if initializing is true then log_event("Found " & drop2Name as string)
            tell drop2Indicator to setIntValue_(1)
        else
            set droplet2exist of dropletsExist to false
            if initializing is true then log_event("MISSING DROPLET " & drop2Name as string)
            tell drop2Indicator to setIntValue_(3)
        end if
        if dropFolderCont as text contains drop3Name then
            set droplet3exist of dropletsExist to true
            set Droplet3Location to (dropletFolder & drop3Name & ".app" as string) as alias
            if initializing is true then log_event("Found " & drop3Name as string)
            tell drop3Indicator to setIntValue_(1)
        else
            set droplet3exist of dropletsExist to false
            if initializing is true then log_event("MISSING DROPLET " & drop3Name as string)
            tell drop3Indicator to setIntValue_(3)
        end if
        log_event("Checking for Droplets...Finished")
    end checkDroplets_
    
    (* ======================================================================
                            Handlers for Preferences!
     ====================================================================== *)
    
    on updateSavefolderLocLabel()
        --Update the text field containing the save folder location
        tell savefolderlocLabel
            setEditable_(1)
            setStringValue_(saveFolderloc)
            setEditable_(0)
        end tell
        log_event("Update save folder location text field...")
    end updateSavefolderLocLabel
    
    on updateRawfolderLocLabel()
        --Update the text field containing the save folder location
        tell rawFolderloclabel
            setEditable_(1)
            setStringValue_(rawFolderloc)
            setEditable_(0)
        end tell
        log_event("Update raw folder location text field...")
    end updateRawfolderLocLabel
    
    on changeSaveFolderloc_(sender)
        --Change the save folder location
        log_event("Change Save folder location...")
        set choice to (choose folder) as string
        tell defaults to setObject_forKey_(choice, "saveFolderloc")
        retrieveDefaults_(me)
        updateSavefolderLocLabel()
        log_event("Change Save folder location...Finished")
    end changeSaveFolderloc_
    
    on showSaveFolder_(sender)
        log_event("Opening Save Folder...")
        tell app "Finder"
            make new Finder window
            activate
            set target of window 1 to saveFolderloc
        end tell
        log_event("Opening Save Folder...Done")
    end showSaveFolder_
    
    on changeRawFolderloc_(sender)
        --Change the save folder location
        log_event("Change Raw folder location...")
        set choice to (choose folder) as string
        tell defaults to setObject_forKey_(choice, "rawFolderloc")
        retrieveDefaults_(me)
        updateRawfolderLocLabel()
        log_event("Change Raw folder location...Finished")
    end changeRawFolderloc_
    
    on showRawFolder_(sender)
        log_event("Opening Raw Folder...")
        tell app "Finder"
            make new Finder window
            activate
            open folder rawFolderloc
        end tell
        log_event("Opening Raw Folder...Done")
    end showRawFolder_
    
    on retrieveDefaults_(sender)
        --Read the preferences from the preferences file
        log_event("Read in Preferences...")
        tell defaults
            set saveFolderloc to objectForKey_("saveFolderloc") as string
            set rawFolderloc to objectForKey_("rawFolderloc") as string
        end tell
        log_event("Save Folder Location: " & saveFolderloc)
        log_event("Raw Folder Location: " & rawFolderloc)
        log_event("Read in Preferences...Finished")
    end retrieveDefaults_
    
    on dropletButtons_(sender)
        log_event("Replace Droplet Button..." & (title of sender as string) as string)
        
        --Check for Droplets
        checkDroplets_(me)
        
        --Declare default vars
        set trueName to false
        set removeDroplet to false
        
        --Figure out what droplet we are replacing
        set buttonName to title of sender as string
        set newDropletLoc to (choose file with prompt "Choose new droplet...")
        --Get filename and remove ".app"
        tell app "Finder" to set newDropName to name of newdropletloc
        set newDropName to (text 1 thru text -5 of newDropName) as string
        --Subtract last character on new droplet location because it adds a ":" to the end of .app files
        set newDropletLoc to newDropletLoc as string
        if (the last character of newDropletLoc is ":") then set newDropletLoc to (text 1 thru -2 of newDropletLoc) as string
        
        --Check new droplet name and allow/disallow renaming of file
        if buttonName = "Droplet 1" then
            if newDropName = drop1Name then set trueName to true
            set dropName to drop1Name
            if droplet1exist of dropletsExist is true then set removeDroplet to true
        else if buttonName = "Droplet 2" then
            if newDropName = drop2Name then set trueName to true
            set dropName to drop2Name
            if droplet2exist of dropletsExist is true then set removeDroplet to true
        else if buttonName = "Droplet 3" then
            if newDropName = drop3Name then set trueName to true
            set dropName to drop3Name
            if droplet3exist of dropletsExist is true then set removeDroplet to true
        end if
        
        --delete the old droplet
        if removeDroplet is true then
            do shell script "rm -rf " & quoted form of POSIX path of (dropletFolder & dropName & ".app" as string)
            log_event("Removed old droplet...")
        end if
        
        try
            --Try to copy in new droplet
            do shell script "cp -rf " & quoted form of POSIX path of newDropletLoc & " " & quoted form of POSIX path of dropletFolder
            log_event("Copied new droplet...")
            --If name is false then change the name
            if trueName is false then
                do shell script "mv " & quoted form of POSIX path of (dropletFolder & newDropName & ".app" as string) & " " & quoted form of POSIX path of (dropletFolder & dropName & ".app" as string)
                log_event("Renamed new droplet...")
            end if
            --log change
            log_event("New Droplet successful!")
            --Check for Droplets again. Temp initializing true
            set initializing to true
            checkDroplets_(me)
            set initializing to false
            
            on error errmsg
                tell me to display dialog "Error when attempting to replace droplet" buttons ("Ok") default button 1 with icon (stop) 
                log_event("Add/New Droplet FAILED...")
        end try
    end dropletButtons_
    
    
    
    (* ======================================================================
                                Handler for logging!
     ====================================================================== *)
    
    on log_event(themessage)
        --Log event, then write to rolling log file.
        log themessage
        set theLine to (do shell script "date  +'%Y-%m-%d %H:%M:%S'" as string) & " " & themessage
        do shell script "echo " & theLine & " >> ~/Library/Logs/RoundHouseHelper.log"
        tell LogWindow
            setEditable_(1)
            insertText_(themessage & return)
            setEditable_(0)
            setSelectable_(0)
        end tell
    end log_event
    
    on checklog()
        log_event("Checking log...")
        --get the count of lines in the log file
        set thecount to (do shell script "wc -l ~/Library/Logs/RoundHouseHelper.log")
        --make the returned string into an integer
        set thecount to (text 1 thru ((offset of the "/" in thecount) - 1) in thecount) as integer
        if thecount > 30000 then
            log_event("Checking log...Log is over 30000 lines!")
            log_event("Checking log...Creating BACKUP of old log")
            do shell script "mv ~/Library/Logs/RoundHouseHelper.log ~/Library/Logs/RoundHouseHelper-BACKUP.log"
            delay 0.3
            log_event("==========PROGRAM INITILIZE=========")
            log_event("------BACKUP OF OLD LOG CREATED-----")
        else
            log_event("Checking log...Done!")
        end if
    end checklog
    
    on reciteFolderContents(theFolderItems,theTitle)
        log_event(theTitle & "...START")
        repeat with i in theFolderItems
            set theName to name of i as text
            log_event(theName)
        end repeat
        log_event(theTitle & "...END")
    end reciteFolderContents
    
end script