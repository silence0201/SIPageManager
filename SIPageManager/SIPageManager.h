//
//  SIPageManager.h
//  Demo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SIPageIntent.h"

@interface SIPageManager : NSObject

#pragma mark --- 调试信息开关
/// 是否开启日志功能
+ (void)setLogEnable:(BOOL)able;

#pragma mark --- 页面跳转
+ (void)showPageWith:(SIPageIntent *)intent;

#pragma mark --- 页面管理
+ (void)registerURL:(NSString *)url forIntent:(SIPageIntent *)intent;
+ (void)deregisterURL:(NSString *)url;
+ (BOOL)handleOpenURL:(NSURL *)url;

@end
