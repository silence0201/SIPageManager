//
//  SIPageIntent.m
//  SIPageManagerDemo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SIPageIntent.h"
#import "UIViewController+Intent.h"

@implementation SIPageIntent

#pragma mark --- 初始化
- (instancetype)init {
    if(self = [super init]) {
        // TODO: 额外参数初始化
    }
    return self;
}

#pragma mark --- 构造方法
+ (instancetype)intentWithController:(UIViewController *)controller
                              method:(SIIntentMethod)method{
    return [self intentWithController:controller method:method withParameters:nil];
}

+ (instancetype)intentWithController:(UIViewController *)controller
                              method:(SIIntentMethod)method
                      withParameters:(NSDictionary *)parameters {
    SIPageIntent *intent = [[SIPageIntent alloc]init];
    intent.targetVc = controller;
    intent.method = method;
    intent.parameters = parameters;
    return intent;
}

+ (instancetype)intentWithStoryboard:(NSString *)aStoryboard aController:(NSString *)aController method:(SIIntentMethod)method withParameters:(NSDictionary *)parameters {
    SIPageIntent *intent = [[SIPageIntent alloc]init];
    intent.aStoryboard = aStoryboard;
    intent.aController = aController;
    intent.method = method;
    intent.parameters = parameters;
    return intent;
}

#pragma mark --- Private Method
- (UIViewController *)targetVc {
    if (!_targetVc) {
        _targetVc = [UIViewController loadWithStoryboard:_aStoryboard name:_aController params:_parameters];
    }
    return _targetVc;
}

- (void)setParameters:(NSDictionary *)parameters {
    _parameters = parameters;
    if (self.targetVc) {
        self.targetVc.vcParams = parameters;
    }
}

@end
