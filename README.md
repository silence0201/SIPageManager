# SIPageManager

一个简单页面管理器(路由表管理页面跳转),支持根据参数对控制器进行赋值

## 安装
### 1. 手动安装
下载项目后,将项目目录下`SIPageManager`拖入项目中

### 2. Pod集成
```
pod 'SIPageManager', '~> 0.1'
```

# 用法

1. 导入头文件

	```objective-c
	#import "SIPageManager.h"
	```

2. 跳转Controller跳转
		
	```objective-c
    SIPageIntent *intent = [SIPageIntent intentWithStoryboard:nil aController:@"PresentViewController" method:SIIntentMethodPresent withParameters:@{@"title":@"present"}];
    intent.destInNav = YES;
    [SIPageManager showPageWith:intent];
    ```
    	
3. 跳转StoryBoard
	
	```objective-c
    SIPageIntent *intent = [SIPageIntent intentWithStoryboard:@"Main" aController:@"StoryboardOneViewController" method:SIIntentMethodPush withParameters:@{@"title":@"Storyboard"}];
    [SIPageManager showPageWith:intent];
    ```
    	
4. 通过注册对象跳转,可以代码注册也支持文件注册
	
	##### 注册:
	
	```objective-c
	 SIPageIntent *intent = [SIPageIntent intentWithStoryboard:nil aController:@"URLViewController" method:SIIntentMethodPush];
    [SIPageManager registerURL:@"test/First" forIntent:intent];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Intent" ofType:@"plist"];
    [SIPageManager registerPathWithFile:filePath];
	```
	
	##### 跳转:
	
	```objective-c
	[SIPageManager handleOpenURL:[NSURL URLWithString:@"jump://test/First?title=URLJump"]];
	[SIPageManager handleOpenURL:[NSURL URLWithString:@"jump://test/Second?title=URL2Jump"]];
	```	
			
5. 支持Action的注册方式
	
	```objective-c
    SIPageIntent *intent = [SIPageIntent intentWithAction:^(UIViewController *currentVc, NSDictionary *params) {
        NSString *msg = [params objectForKey:@"Message"] ?: @"Messgae";
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Title" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Params:%@",params);
        }];
        [controller addAction:action];
        [currentVc presentViewController:controller animated:YES completion:nil];
    }];
    [SIPageManager registerPath:@"test/action" forIntent:intent];
    ```
    	
6. 执行Action,注意如果url中有中文字段,请对URL进行编码


	```objective-c
    NSString *urlStr = @"jump://test/action?title=URLAction&Message=额外消息";
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [SIPageManager handleOpenURL:url];
    ```
    
7. 更多使用方法请查看头文件
    	

## SIPageManager
SIPageManager is available under the MIT license. See the LICENSE file for more info.
