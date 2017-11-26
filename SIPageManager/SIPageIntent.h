//
//  SIPageIntent.h
//  SIPageManagerDemo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SIIntentMethod) {
    SIIntentMethodPush,
    SIIntentMethodPop,
    SIIntentMethodPresent,
    SIIntentMethodDismiss
};

typedef void(^IntentCompletion)(void);

@interface SIPageIntent : NSObject

#pragma mark --- 基本参数
/// 页面跳转方式
@property (nonatomic,assign) SIIntentMethod method;

/// 目标Controller
@property (nonatomic,strong) UIViewController *targetVc ;
/// 附带参数
@property (nonatomic,copy) NSDictionary *parameters;

/// StoryBoard初始化Controller表示
@property (nonatomic,copy) NSString *aController;
/// StoryBoard名
@property (nonatomic,copy) NSString *aStoryboard;

#pragma mark --- 扩展参数
/// Present方式完成回调
@property (nonatomic,copy) IntentCompletion completion;
/// 是否有动画,默认为YES
@property (nonatomic,assign) BOOL animated;
/// Push方式跳转是否隐藏导航栏
@property (nonatomic,assign) BOOL showBottomBarWhenPushed;
/// Present方式是否添加导航栏,默认不添加
@property (nonatomic,assign) BOOL destInNav;

#pragma mark --- 构造方法
/// 通过控制器实例创建
+ (instancetype)intentWithController:(UIViewController *)controller
                              method:(SIIntentMethod)method;
/// 通过控制器创建,附带参数
+ (instancetype)intentWithController:(UIViewController *)controller
                              method:(SIIntentMethod)method
                      withParameters:(NSDictionary *)parameters;

/// 通过StoryBoard或者类名创建
+ (instancetype)intentWithStoryboard:(NSString *)aStoryboard
                         aController:(NSString *)aController
                              method:(SIIntentMethod)method;
/// 通过StoryBoard或者类名创建,附带参数
+ (instancetype)intentWithStoryboard:(NSString *)aStoryboard
                         aController:(NSString *)aController
                              method:(SIIntentMethod)method
                      withParameters:(NSDictionary *)parameters;

@end
