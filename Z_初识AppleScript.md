```Shell
sdef /Applications/Mail.app | sdp -fh -o ~/Desktop --basename Mail --bundleid `defaults read "/Applications/Mail.app/Contents/Info" CFBundleIdentifier`
```

