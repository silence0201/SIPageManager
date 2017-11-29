//
//  AppDelegate.m
//  Demo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AppDelegate.h"
#import "SIPageManager.h"

#ifdef DEBUG
#define SILog(...)      printf("[%s]:%s\n", __TIME__ , [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define SILog(...)
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //SIPageIntent *intent = [SIPageIntent intentWithStoryboard:nil aController:@"URLViewController" method:SIIntentMethodPush];
    // [SIPageManager registerURL:@"test" forIntent:intent];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Intent" ofType:@"plist"];
    [SIPageManager registerPathWithFile:filePath];
    
    SIPageIntent *intent = [SIPageIntent intentWithAction:^(UIViewController *currentVc, NSDictionary *params) {
        NSString *msg = [params objectForKey:@"Message"] ?: @"Messgae";
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Title" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SILog(@"Params:%@",params);
        }];
        [controller addAction:action];
        [currentVc presentViewController:controller animated:YES completion:nil];
    }];
    [SIPageManager registerPath:@"test/action" forIntent:intent];
    
    
    [SIPageManager setLogEnable:YES];
    return YES;
}


@end
