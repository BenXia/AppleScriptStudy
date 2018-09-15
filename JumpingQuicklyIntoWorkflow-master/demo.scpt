

if application "iTerm" is not running then
	do shell script "open /Applications/iTerm.app"
end if


tell application "iTerm"
  -- TAB 1 --
  tell current window
    create tab with default profile
  end tell

  -- Falcon Server --
  tell first session of current tab of current window
    set name to "falcon-server home"
    write text "hello npm"

    delay 5

    split horizontally with default profile
    split vertically with default profile
  end tell

  -- PyCharm --
  tell third session of current tab of current window
    set name to "falcon-server shell"

    split vertically with default profile
  end tell

  -- Falcon Admin --
  tell fourth session of current tab of current window
    set name to "falcon-server front"

    write text "echo world"
  end tell


end tell
