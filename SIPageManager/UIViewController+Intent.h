//
//  UIViewController+Intent.h
//  Demo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Intent)

/// ViewController附带参数,如果有对应的Key会自动赋值
@property (nonatomic,strong) NSDictionary *vcParams;

/// 通过StoryBoard加载控制器,如果StoryBoard为nil根据类名加载
+ (UIViewController *)loadWithStoryboard:(NSString *)aStoryboard
                                    name:(NSString *)name
                                  params:(NSDictionary *)aParams;

@end
