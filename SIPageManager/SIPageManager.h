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
/// 页面跳转
+ (void)showPageWith:(SIPageIntent *)intent;

#pragma mark --- 页面管理
/// 注册对应页面URL
+ (void)registerURL:(NSString *)url forIntent:(SIPageIntent *)intent;
/// 取消注册
+ (void)deregisterURL:(NSString *)url;
/// 通过URL方式实现页面跳转
+ (BOOL)handleOpenURL:(NSURL *)url;

@end
