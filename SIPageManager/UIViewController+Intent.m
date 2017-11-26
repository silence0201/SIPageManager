//
//  UIViewController+Intent.m
//  Demo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "UIViewController+Intent.h"
#import <objc/runtime.h>

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
