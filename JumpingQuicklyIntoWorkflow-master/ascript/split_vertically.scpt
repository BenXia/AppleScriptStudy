tell application "iTerm2"
  tell first session of current tab of current window
    split vertically with profile "Default"
  end tell
end tell
