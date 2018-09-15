#!/usr/bin/env osascript -l JavaScript

// 将改文件保存为 testAlert.js 后 chmod +x ./testAlert.js 然后可以通过命令行
// ./testAlert.js echo aaa bbb ccc 测试使用

// 顺便说一下可以在 shell 中输入osascript -il JavaScript 进入命令行交互式运行环境REPL(read-eval-print-loop)
// osascript -il JavaScript
// >> var app = Application.currentApplication()           //这是获取当前运行的app
// => undefined        //交互环境的返回值，这里先不用管
// >> app.includeStandardAdditions = true      //打开允许运行脚本
// => true
// app.displayAlert('wow', { message: 'I like JavaScript' })

// 引用c的函数库
ObjC.import('stdlib')  // 这样引用的函数，都在$.这个域下面

function run(argv) {
    // 似乎相当于 main 函数，是自动启动的
    argc = argv.length  // If you want to iterate through each arg.

    status = $.system(argv.join(" "))   // 相当于c的system(...)
    // 这里实际是吧所有参数当作参数来执行一个system调用

    $.exit(status >> 8)   // 使用c函数exit来退出程序并给出返回值
}

// 引用函数库，默认情况下，系统可以从三个位置搜索函数库：
// 1.~/Library/Script Libraries/
// 2.一个macos app包的Contents/Library/Script Libraries/路径。（这个从OSX10.11开始支持）
// 3.从环境参量OSA_LIBRARY_PATH中寻找，多个路径跟PATH一样，中间用“：”隔开。（这个也是从OSX10.11)开始支持。

// 说一下可以写一个库函数
// function log(message) {
//     TextEdit = Application('TextEdit')
//     doc = TextEdit.documents['Log.rtf']
//     doc.text = message
// }

// 功能很简单，就是利用系统的文本编辑器将输出信息保存为一个rtf文件。以上代码保存为文件名为toolbox.scpt的文本文件，记住脚本库文件必须用.scpt后缀。这个库文件我们放到~/Library/Script Libraries/路径下。随后可以在REPL环境下测试使用这个库文件：

// toolbox = Library('toolbox')
// toolbox.log('Hello world')

// 这个方法是官方推荐的校本库编写和调用方法，实际上我们还可以用类似node.js方法，这种方法首先要自己写一个基本的引入函数：

// var require = function (path) {
//  if (typeof app === 'undefined') {
//    app = Application.currentApplication();
//    app.includeStandardAdditions = true;
//  }
//
//  var handle = app.openForAccess(path);
//  var contents = app.read(handle);
//  app.closeAccess(path);
//
//  var module = {exports: {}};
//  var exports = module.exports;
//  eval(contents);
//
//  return module.exports;
//};

// 然后程序中就可以使用类似这样的方法来调用库函数:
// 
// app=require('node_modules/jxapp/index.js')
// app.displayAlert("text") 

// 这个例子仅供示例，并没有实际作用，因为上面的require函数中实际上我们已经得到了app的实例。使用node.js的库函数的时候有两个注意事项：
// 1. jxa实际并非在浏览器环境运行的，这一点很类似node.js的服务器端，所以要注意global和window两个预置的变量是不存在的，可以在程序一开始设定window=this;global=this;来规避库内部的调用。这个问题其实前几天我们说AngularJS2的时候也提到了。
// 2. 调用node.js库，目前主要还是使用Browserify来实现的，所以要提前使用安装相关包：
//     npm install -g browserify   
//     npm install coffeeify lodash  coffeescript
// 
// 具体的使用方法可以参考上面资源链接中的例子，这里就不展开了。


