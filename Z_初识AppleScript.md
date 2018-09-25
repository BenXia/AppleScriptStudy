## 初始 AppleScript



首先了解一下 Apple 公司创造 AppleScript 的初衷，它是用来编写运行于mac的脚本的。重要的是它是 mac 上操作应用程序为数不多的途径之一。非常方便实现一些平常工作中重复工作的脚本化，提升工作效率，避免重复劳动。

### AppleScript 有啥用？

-----------------

- 可以用来书写脚本直接生成脚本文件(.scpt)、App 文件；

- 可以用来编写 Cocoa App（也可以创建 Automation Action）；

- 可以在 Alfred.app 和 Autormator.app 中使用；

- 可以非常方便的在 Shell 和 OC 中调用执行；



### AppleScript 编辑器

-----------------

MacOS 上有自带的脚本编辑器，目前支持 AppleScript 和 JavaScript。
其中有模版工程、模版代码、应用词典等功能，极大方便了 AppleScript/JavaScript 脚本的编写。
![Editor](./Z_resources/1.ScriptEditor.png)

![Editor](./Z_resources/2.ScriptEditor.png)



### 基础语法

-----------------







### 生成一些 Cocoa App 的 OC 接口文件

-----------------


```Shell
sdef /Applications/Mail.app | sdp -fh -o ~/Desktop --basename Mail --bundleid `defaults read "/Applications/Mail.app/Contents/Info" CFBundleIdentifier`
```



### 更多资料

-----------------

[AppleScript Language Guide 官方文档](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html)

[Mac Automation Scripting Guide](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/MakeaSystem-WideService.html#//apple_ref/doc/uid/TP40016239-CH46-SW1)

[AppleScript 与 Shell 的互相调用](https://support.apple.com/zh-cn/guide/terminal/trml1003/mac)

[Objective-C 运行 AppleScript 脚本](https://blog.csdn.net/SysProgram/article/details/46817917)

[如何让 Cocoa App 支持 AppleScript ](https://www.aliyun.com/jiaocheng/376240.html?spm=5176.100033.2.11.2a7d9a70mlzSWR)

[AppleScript for Absolute Starters](http://www.docin.com/p-515251458.html)

[Apple Automator with AppleScript](http://ishare.iask.sina.com.cn/f/33325750.html)

[JavaScript for Automation](https://developer.apple.com/library/archive/releasenotes/InterapplicationCommunication/RN-JavaScriptForAutomation/Articles/Introduction.html#//apple_ref/doc/uid/TP40014508-CH111-SW1)

[JXA-Cookbook](https://github.com/JXA-Cookbook/JXA-Cookbook/wiki/Foreword)

