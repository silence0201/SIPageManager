//
//  ViewController.m
//  Demo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "SIPageManager.h"

#ifdef DEBUG
#define SILog(...)      printf("[%s]:%s\n", __TIME__ , [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define SILog(...)
#endif

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
    [SIPageManager handleOpenURL:[NSURL URLWithString:@"jump://test/First?title=URLJump"]];
}
- (IBAction)url2Vc:(id)sender {
    [SIPageManager handleOpenURL:[NSURL URLWithString:@"jump://test/Second?title=URL2Jump"]];
}

- (IBAction)pushVc:(id)sender {
    SIPageIntent *intent = [SIPageIntent intentWithStoryboard:nil aController:@"PushViewController" method:SIIntentMethodPush withParameters:@{@"title":@"push方法"}];
    [SIPageManager showPageWith:intent];
}
- (IBAction)storyBoardVc:(id)sender {
    SIPageIntent *intent = [SIPageIntent intentWithStoryboard:@"Main" aController:@"StoryboardOneViewController" method:SIIntentMethodPush withParameters:@{@"title":@"Storyboard"}];
    [SIPageManager showPageWith:intent];
}
- (IBAction)actionTest:(id)sender {
    SIPageIntent *intent = [SIPageIntent intentWithAction:^(UIViewController *currentVc, NSDictionary *params) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Title" message:@"Message" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SILog(@"Params:%@",params);
        }];
        [controller addAction:action];
        [currentVc presentViewController:controller animated:YES completion:nil];
    }];
    [SIPageManager showPageWith:intent];
}
- (IBAction)actionURL:(id)sender {
    NSString *urlStr = @"jump://test/action?title=URLAction&Message=额外消息";
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [SIPageManager handleOpenURL:url];
}

@end


