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

@end


