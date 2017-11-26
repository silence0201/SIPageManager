//
//  AppDelegate.m
//  Demo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AppDelegate.h"
#import "SIPageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        SIPageIntent *intent = [SIPageIntent intentWithStoryboard:nil aController:@"URLViewController" method:SIIntentMethodPush];
    [SIPageManager registerURL:@"test" forIntent:intent];
    [SIPageManager setLogEnable:YES];
    return YES;
}


@end
