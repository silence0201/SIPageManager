//
//  SIPageIntent.h
//  SIPageManagerDemo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SIIntentMethod) {
    SIIntentMethodPush,
    SIIntentMethodPop,
    SIIntentMethodPresent,
    SIIntentMethodDismiss
};

@interface SIPageIntent : NSObject

@end
