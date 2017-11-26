//
//  UIViewController+Intent.h
//  Demo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Intent)

@property (nonatomic,strong) NSDictionary *vcParams;

+ (UIViewController *)loadWithStoryboard:(NSString *)aStoryboard
                                    name:(NSString *)name
                                  params:(NSDictionary *)aParams;

@end
