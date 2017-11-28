//
//  ViewController.m
//  Demo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "SIPageManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)persentVc:(id)sender {
    SIPageIntent *intent = [SIPageIntent intentWithStoryboard:nil aController:@"PresentViewController" method:SIIntentMethodPresent withParameters:@{@"title":@"present"}];
    intent.destInNav = YES;
    [SIPageManager showPageWith:intent];
}
- (IBAction)urlVc:(id)sender {
    [SIPageManager handleOpenURL:[NSURL URLWithString:@"jump://test?title=URLJump"]];
}
- (IBAction)url2Vc:(id)sender {
    [SIPageManager handleOpenURL:[NSURL URLWithString:@"jump://test2?title=URL2Jump"]];
}

- (IBAction)pushVc:(id)sender {
    SIPageIntent *intent = [SIPageIntent intentWithStoryboard:nil aController:@"PushViewController" method:SIIntentMethodPush withParameters:@{@"title":@"push方法"}];
    [SIPageManager showPageWith:intent];
}
- (IBAction)storyBoardVc:(id)sender {
    SIPageIntent *intent = [SIPageIntent intentWithStoryboard:@"Main" aController:@"StoryboardOneViewController" method:SIIntentMethodPush withParameters:@{@"title":@"Storyboard"}];
    [SIPageManager showPageWith:intent];
}

@end

#pragma mark - 中文输出
#pragma mark -
#ifdef DEBUG
@implementation NSArray (LocaleLog)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *mStr = [NSMutableString stringWithString:@"[\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [mStr appendFormat:@"\t%@,\n", obj];
    }];
    [mStr appendString:@"]"];
    NSRange range = [mStr rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound){
        [mStr deleteCharactersInRange:range];
    }
    return mStr;
}

@end

@implementation NSDictionary (LocaleLog)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *mStr = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [mStr appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [mStr appendString:@"}"];
    NSRange range = [mStr rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound){
        [mStr deleteCharactersInRange:range];
    }
    return mStr;
}
@end
#endif


