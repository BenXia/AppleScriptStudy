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

- 基本数据类型

  > AppleScript有4种最基本的数据类型：number、string、list和record，分别对应编程概念中的数值、字符串、数组和字典。

  - number 类型

    ```AppleScript
    set x to 2
    get x
    set y to 3
    get y
    set xy to x * y
    set x3 to y ^ 3
    ```

  - string 类型

    ```AppleScript
    set strX to "Hello "
    set strY to "AppleScript"
    
    -- 字符串拼接
    set strXY to strX & strY
    -- 获取字符串长度
    set lengthOfStrXY to the length of strXY
    
    -- 分割成单个字符并组成一个新的列表
    set charList to every character of strXY
    
    -- 通过 AppleScript's text item delimiters 来指定分隔号，然后通过 every text item of 来实现分割
    set defaultDelimiters to AppleScript's text item delimiters
    set AppleScript's text item delimiters to " "
    set listAfterDelimiter to every text item of strXY
    set AppleScript's text item delimiters to defaultDelimiters
    
    
    -- number 与 string 类型转换
    set numberToString to 100 as string
    set stringToNumber to "1234" as number
    ```

  - list 类型

    ```AppleScript
    set firstList to { 100, 200.0, "djfif", -10 }
    set emptyList to {}
    set currentList to { 2, 3, 4, 5 }
    
    -- 列表拼接
    set modifiedList to firstList & emptyList & currentList
    
    -- 获取和更改列表中的元素
    set item 2 of modifiedList to "2"
    get modifiedList
    set the third item of modifiedList to "abcde"
    get modifiedList
    
    -- 用列表中的随机元素赋值
    set randomX to some item of modifiedList
    
    -- 获取最后一个元素
    set lastItem to the last item of modifiedList
    
    -- 负数表示从列表尾端开始获取元素
    set aLastItem to item -2 of modifiedList
    
    -- 获取第一个元素
    set firstItem to the first item of modifiedList
    
    set longList to { 1,2,3,4,5,6,7,8,9,10 }
    set shortList to items 6 through 8 of longList
    
    -- 逆向获取子列表
    set reversedList to reverse of longList
    set listCount to the count of longList
    set the end of longList to 5
    get longList
    
    -- 将 string 转换为 list
    set string1 to "string1"
    set stringList to string1 as list
    
    -- 可以用&将字符串和列表连接起来，结果取决于&前面的变量
    set strAndList to string1 & stringList
    ```

  - record 类型

    ```
    set aRecord to { name1:100, name2:"This is a record"}
    set valueOfName1 to the name1 of aRecord
    
    set newRecord to { name1:name1 of aRecord }
    
    set numberOfProperties to the count of aRecord
    ```

- 条件/循环

  ```AppleScript
  set x to 500
  
  if x > 100 then
  	display alert "x > 100"
  else if x > 10 then
      display alert "x > 10"
  else
      display alert "x <= 10"
  end if
  
  
  set sum to 0
  set i to 0
  repeat 100 times
      set i to i + 1
      set sum to sum + i
  end repeat
  get sum
  
  
  repeat with counter from 0 to 10 by 2
      display dialog counter
  end repeat
  
  set counter to 0
  set listToSet to {}
  -- 注意下这个 ≠ 符号是使用 Option+= 输入的
  repeat while counter ≠ 10
  	-- display dialog counter as string
  	set listToSet to listToSet & counter
  	set counter to counter + 2
  end repeat
  get listToSet
  
  set counter to 0
  set listToSet to {}
  repeat until counter = 10
      -- display dialog counter as string
      set listToSet to listToSet & counter
      set counter to counter + 2
  end repeat
  get listToSet
  
  set aList to { 1, 2, 8 }
  repeat with anItem in aList
      display dialog anItem as string
  end repeat
  ```

- 注释

  ```AppleScript
  -- 这是单行的注释
  
  (*
  这是多行的注释
  这是多行的注释
  *)
  ```

- 函数

  ```AppleScript
  on showAlert(alertStr)
  	display alert alertStr buttons {"I know", "Cancel"} default button "I know"
  end showAlert
  
  showAlert("hello world")
  ```

- 换行

  ```AppleScript
  -- 键盘使用组合键 Option+L 输入'¬' 可以实现代码折行
  on showAlert(alertStr)
  	display alert alertStr ¬
  		buttons {"I know", "Cancel"} default button "I know"
  end showAlert
  
  showAlert("hello world")
  ```

- 使用AppleScript中的对话框

  > 使用弹出框有一些要注意的地方:
  >
  > * 1.它可以有多个按钮的;
  > * 2.它是有返回值的,返回值是你最终操作的字符串;
  > * 3.它是可以增加输入框的，而且比你想的简单多了;

  ```
  set dialogString to "Input a number here"
  set returnedString to display dialog dialogString default answer ""
  get returnedString
  //{button returned:"好", text returned:"asdf"}
  
  set dialogString to "Input a number here"
  set returnedString to display dialog dialogString default answer ""
  set returnedNumber to the text returned of returnedString
  try
  	set returnedNumber to returnedNumber as number
  	set calNumber to returnedNumber * 100
  	display dialog calNumber
  on error the error_message number the error_number
  	display dialog "Error:" & the error_number & " Details:" & the error_message
  end try
  beep
  ```

- 预定义变量

  > 就是一些特殊的关键字，类似于其他语言中的 self、return等，有固定的含义；
  >
  > 千万不要用它来自定义变量。

  - **result**：记录最近一个命令执行的结果，如果命令没有结果，那么将会得到错误

  - **it**：指代最近的一个 tell 对象

  - **me**：这指代段脚本。用法举例 path to me 返回本脚本所在绝对路径

  - **tab**：用于string，一个制表位

  - **return**：用于string，一个换行

- 字符串比较：Considering/Ignoring语句

  在 AppleScript 的字符串比较方式中，你可以设定比较的方式：上面 considering 和 ignoring 含义都是清晰的，一个用于加上xx特征，一个用于忽略某个特征；一个特征就是一个attribute。
  atrribute应该为列表中的任意一个:

  - **case** 大小写
  - **diacriticals** 字母变调符号(如e和é)
  - **hyphens** 连字符(-)
  - **numeric strings** 数字化字符串(默认是忽略的)，用于比较版本号时启用它。
  - **punctuation** 标点符号(,.?!等等,包括中文标点)
  - **white space** 空格

          ```
  ignoring case
  	if "AAA" = "aaa" then
  		display alert "AAA equal aaa when ignoring case"
  	end if
  end ignoring
  
  considering numeric strings
  	if "10.3" > "9.3" then
  		display alert "10.3 > 9.3"
  	end if
  end considering
          ```

- 列表选择对话框

  ```
  display alert "这是一个警告" message "这是警告的内容" as warning
  
  choose from list {"选项1", "选项2", "选项3"} with title "选择框" with prompt "请选择选项"
  ```

  选择框有以下参数:

  - 直接参数 紧跟list类型参数，包含所有备选项

  - **title** 紧跟text，指定对话框的标题

  - **prompt** 紧跟text，指定提示信息

  - **default items** 紧跟list，指定默认选择的项目

  - **empty selection allowed** 后紧跟true表示允许不选

  - **multiple selections allowed** 后紧跟true表示允许多选

- 文件选择对话框

  ```
  -- 选取文件名称Choose File Name
  choose file name with prompt "指定提示信息"
  
  -- 选取文件夹Choose Folder
  choose folder with prompt "指定提示信息" default location file "Macintosh HD:Users" with invisibles, multiple selections allowed and showing package contents
  
  -- 选取文件Choose File
  choose file of type {"txt"}
  ```

- 文件读取和写入

  > 文件读取用read，允许直接读取；
  >
  > 但是写入文件之前必须先打开文件，打开文件是open for access FileName；
  >
  > 写入文件用write...to语句；
  >
  > 最后记得关闭文件close access filePoint

  ```
  set myFile to alias "Macintosh HD:Users:xiaxuqiang:Desktop:example.txt"
  read myFile
  set aFile to alias "Macintosh HD:Users:xiaxuqiang:Desktop:example.txt"
  set fp to open for access aFile with write permission
  write "AppleScript写入文本" to fp
  close access fp
  
  
  --在桌面上创建一个文件,内部包含一个txt文件,并向txt内插入文件
  on createMyTxt()
  	tell application "Finder"
  		make new folder at desktop with properties {name:"star"}
  		make new file at folder "star" of desktop with properties {name:"star.txt"}
  	end tell
  end createMyTxt
  
  --向txt文件内写入内容
  on writeTextToFile()
  	set txtFile to alias "Macintosh HD:Users:xiaxuqiang:Desktop:star:star.txt"
  	set fp to open for access txtFile with write permission
  	write "你好,这是一个txt文件" to fp as «class utf8»
  	close access fp
  end writeTextToFile
  
  createMyTxt()
  
  writeTextToFile()
  
  
  ```

### 案例列举

----------
- 使用 mac 的邮件系统

  ```
  --Variables
  set recipientName to " 小红"
  set recipientAddress to "aliyunzixun@xxx.com"
  set theSubject to "AppleScript Automated Email"
  set theContent to "This email was created and sent using AppleScript!"
  --Mail Tell Block
  tell application "Mail"
  	--Create the message
  	set theMessage to make new outgoing message with properties {subject:theSubject, content:theContent, visible:true}
  	--Set a recipient
  	tell theMessage
  		make new to recipient with properties {name:recipientName, address:recipientAddress}
  		--Send the Message
  		send
  	end tell
  end tell
  ```

- 让浏览器打开网页

  ```
  set urlMyBlog to "https://blog.csdn.net/sodaslay"
  set urlChinaSearch to "http://www.chinaso.com"
  set urlBiying to "https://cn.bing.com"
  
  --使用Chrome浏览器
  tell application "Google Chrome"
  	--新建一个chrome窗口
  	set window1 to make new window
  	tell window1
  		--当前标签页加载必应,就是不用百度哈哈
  		set currTab to active tab of window1
  		set URL of currTab to urlBiying
  		--打开csdn博客,搜索
  		make new tab with properties {URL:urlMyBlog}
  		make new tab with properties {URL:urlChinaSearch}
  		--将焦点由最后一个打开的标签页还给首个标签页
  		set active tab index of window1 to 1
  	end tell
  end tell
  
  ```

- 让你的电脑说话

  ```
  -- You can use any of the voices from the System Voice pop-up on the Text to Speech tab in the Speech preferences pane.
  -- Default Value:
  -- The current System Voice (set in the Speech panel in System Preferences.
  
  tell current application
  	say "My name is LiMei. Nice to meet you. How are you?" using "Veena"
  	say "Fine, thanks. And you?" using "Victoria"
  	say "滚"
  	say "我跟你说" using "Sin-Ji"
  end tell
  
  beep
  ```

- 调用 mac 的通知中心

  > crontab + AppleScript + 通知中心 可以做很多定制的提醒工具

  ```
  display notification "message" with title "title" subtitle "subtitle"
  
  display notification "message" sound name "Bottle.aiff"
  -- 声音文件都在 ~/Library/Sounds 和 /System/Library/Sounds 下面
  ```

- 清理废纸篓

  ```
  tell application "Finder"
  	empty the trash
  	beep
  	open the startup disk
  end tell
  ```



###  何时使用？

-------

- 一些跨应用的重复操作步骤使用 AppleScript/JavaScript 实现关键步骤
- 结合 Alread.app、Automator.app、crontab 等实现一些场景的触发调用
- 本地的一些工具脚本可以直接调用 AppleScript 做一些简单的输入、弹框、通知交互
- 用 AppleScript 写一个 CocoaApp 或者 Automator Action（**但是可以用 Objective-C 我们就没必要使用相对不熟悉的 AppleScript**）
- OC 的命令行工程可以借助 NSAppleScript 操作其它应用
- CocoaApp 工程可以通过 XPCService+ScriptingBridge+AppleScript(OC版本接口调用)



### 生成 Cocoa App 的 OC 接口文件

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

