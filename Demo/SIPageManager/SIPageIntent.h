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

@interface SIPageIntent : NSObject

#pragma mark --- 基本参数
@property (nonatomic,assign) SIIntentMethod method;

@property (nonatomic,strong) UIViewController *targetVc ;
@property (nonatomic,copy) NSDictionary *parameters;

@property (nonatomic,copy) NSString *aController;
@property (nonatomic,copy) NSString *aStoryboard;

#pragma mark --- 扩展参数

#pragma mark --- 构造方法
+ (instancetype)intentWithController:(UIViewController *)controller
                              method:(SIIntentMethod)method;
+ (instancetype)intentWithController:(UIViewController *)controller
                              method:(SIIntentMethod)method
                      withParameters:(NSDictionary *)parameters;

+ (instancetype)intentWithStoryboard:(NSString *)aStoryboard
                         aController:(NSString *)aController
                              method:(SIIntentMethod)method;
+ (instancetype)intentWithStoryboard:(NSString *)aStoryboard
                         aController:(NSString *)aController
                              method:(SIIntentMethod)method
                      withParameters:(NSDictionary *)parameters;

@end
