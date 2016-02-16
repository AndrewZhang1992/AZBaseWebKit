# AZBaseWebKit

> u can fast use UIWebview(ios 7.0) or WKWebView( ios 8.0 later) .it's contain NJK 



### 说明
>   当前 h5 和 客户端的结合越来约密切。所以 使用 webview 来作为桥梁。但是ios8.0以前只有 UIWebView 来使用，但是 UIWebView 导致的内存泄露相当厉害，ios8.0 之后 apple 给出了 WKWebView 来替换 UIWebView。 WKWebView 最大优点就是 大大的减少了因 webkit 导致的内存泄露问题，但是WKWebView 的使用方式 和 UIWebView 有一定不同。

###### AZBaseWebKit 兼容ios7.0，即在iOS7.0 仍然使用 UIWebView 而在iOS8.0 之后 使用 WKWebView。内部已经引入 NJK 





### 如何加入到你的项目中？
导入AZBaseWebKit，引入头文件

```
#import "AZBaseWebVC.h"

```

###  使用


你可以新建一个UIViewController继承自 AZBaseWebVC ，以此方便扩展新的功能。你也可以直接使用  AZBaseWebVC

```
    AZBaseWebVC *webVC=[AZBaseWebVC new];
    webVC.urlStr=@"https://www.baidu.com";
    [self.navigationController pushViewController:webVC animated:YES];

```

### 其他


AZBaseWebVC 对外：

```
/**
 *  最大网络等待时间
 */
static const float WEB_TIMEOUT=15.0;



/**
 *  >= ios 8 为 WKWebView 。 < ios8.0 为 UIWebView
 */
@property (nonatomic,weak)id webView;


/**
 *  是否显示njk 进度条。默认：YES 显示
 */
@property (nonatomic,assign)BOOL isShowNJK;


/**
 *  请求URL
 */
@property (nonatomic,copy)NSString *urlStr;



/** 开始请求 */
-(void)loadRequest:(NSString *)urlStr;


/**
 *  执行 javaScript 内部分开 wkwebview 和 uiwebview
 *
 *  @param javaScript 内容
 *
 *  @param completionHandler  执行完结果回调
 */
-(void)azEvaluateingJavaScript:(NSString *)javaScript andcompletionHandler:(azCompletionHandler) completionHandler;


```

#### 执行js

执行js脚本

```
 @weakify(self);
        
 [self azEvaluateingJavaScript:@"document.title" andcompletionHandler:^(NSString * _Nullable value, NSError * _Nullable error) {
            @strongify(self);
            self.title=value;
            [self registeJavaScriptToWebView];
        }];
        
 
```

动态注入js ，再调用

```
  // 注入js 输入框聚焦
  [self azEvaluateingJavaScript:@"var script = document.createElement('script');"
         "script.type = 'text/javascript';"
         "script.text = \"function AZInputTextFoucs() {  var textBox = $('#commentTextBox');\
         textBox.focus();\
         }\";"
         "document.getElementsByTagName('head')[0].appendChild(script);" andcompletionHandler:nil];
         
  //调用
  [self azEvaluateingJavaScript:@"AZInputTextFoucs();" andcompletionHandler:nil];


```


