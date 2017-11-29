//
//  SIPageIntent.m
//  SIPageManagerDemo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SIPageIntent.h"
#import <objc/runtime.h>

@implementation SIPageIntent

#pragma mark --- 初始化
- (instancetype)init {
    if(self = [super init]) {
        // 额外参数初始化
        self.animated = YES;
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

+ (instancetype)intentWithStoryboard:(NSString *)aStoryboard
                         aController:(NSString *)aController
                              method:(SIIntentMethod)method {
    return [self intentWithStoryboard:aStoryboard aController:aController method:method withParameters:nil];
}

+ (instancetype)intentWithStoryboard:(NSString *)aStoryboard aController:(NSString *)aController method:(SIIntentMethod)method withParameters:(NSDictionary *)parameters {
    SIPageIntent *intent = [[SIPageIntent alloc]init];
    intent.aStoryboard = aStoryboard;
    intent.aController = aController;
    intent.method = method;
    intent.parameters = parameters;
    return intent;
}

+ (instancetype)intentWithAction:(IntentAction)action {
    SIPageIntent *intent = [[SIPageIntent alloc]init];
    intent.intentAction = action;
    intent.method = SIIntentMethodAction;
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

#pragma mark --- UIViewController+Intent
@implementation UIViewController (Intent)

+ (UIViewController *)loadWithStoryboard:(NSString *)aStoryboard
                                    name:(NSString *)name
                                  params:(NSDictionary *)aParams {
    if (!name || name.length == 0) {
        return nil;
    }
    
    UIViewController *viewController = nil ;
    if (aStoryboard && aStoryboard.length > 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:aStoryboard bundle:nil];
        if (aStoryboard) {
            viewController = [storyboard instantiateViewControllerWithIdentifier:name];
        }
    }
    
    Class clazz = NSClassFromString(name);
    if (clazz && !viewController) {
        viewController = [[clazz alloc] init];
    }
    
    viewController.vcParams = aParams;
    
    return viewController;
}

#pragma mark --- 关联变量
- (NSDictionary *)vcParams {
    id params = objc_getAssociatedObject(self, @selector(vcParams));
    if ([params isKindOfClass:[NSDictionary class]]) {
        return params;
    }
    return nil;
}

- (void)setVcParams:(NSDictionary *)vcParams {
    if (!vcParams || ![vcParams isKindOfClass:[NSDictionary class]]) return;
    objc_setAssociatedObject(self, @selector(vcParams), vcParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 遍历是否存在对应的Key
    for (NSString *key in vcParams.allKeys) {
        id value = vcParams[key];
        if (value && ![value isKindOfClass:[NSNull class]]) {
            NSString *selStr = [NSString stringWithFormat:@"set%@:",key.localizedCapitalizedString];
            SEL sel = NSSelectorFromString(selStr);
            if ([self respondsToSelector:sel]) {
                [self setValue:value forKey:key];
            }
        }
    }
}

@end
