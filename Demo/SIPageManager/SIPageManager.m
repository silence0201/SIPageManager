//
//  SIPageManager.m
//  Demo
//
//  Created by Silence on 2017/11/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SIPageManager.h"

static SIPageManager *sharedManager;

@interface SIPageManager()

@property (nonatomic, assign) BOOL logAbel;  // 是否开启日志打印
@property (nonatomic, strong) SIPageIntent *intent ;  // 要跳转的页面
@property (nonatomic, strong) NSMutableDictionary *pathRegister;  // 注册对应路径

@end

@implementation SIPageManager

#pragma mark --- 初始化
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SIPageManager alloc]init];
    });
    return sharedManager;
}

#pragma mark --- 初始化
- (instancetype)init {
    if (sharedManager) return sharedManager;
    if (self = [super init]) {
        // 初始化
        self.pathRegister = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark --- 获取页面
+ (UIViewController *)rootViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    // app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result=nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController *nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}

+ (UINavigationController *)rootNavigationController{
    return [self rootViewController].navigationController;
}


#pragma mark --- 页面跳转
+ (void)pushWithIntent:(SIPageIntent *)intent {
    if (!intent.targetVc) return;
    intent.targetVc.hidesBottomBarWhenPushed =  !intent.showBottomBarWhenPushed;
    UINavigationController *nav = [self rootNavigationController];
    [nav pushViewController:intent.targetVc animated:intent.animated];
}

+ (void)popWithIntent:(SIPageIntent *)intent {
    if (!intent.targetVc) return;
    UINavigationController *nav = [self rootNavigationController];
    [nav popViewControllerAnimated:intent.animated];
}

+ (void)presentWithIntent:(SIPageIntent *)intent{
    if (!intent.targetVc) return;
    UIViewController *sourceVC = [self rootViewController];
    UIViewController *destVC = intent.targetVc;
    if (intent.destInNav) {
        if (destVC.navigationController) {
            destVC = destVC.navigationController;
        }else{
            destVC = [[UINavigationController alloc] initWithRootViewController:destVC];
        }
    }
    
    [sourceVC presentViewController:destVC animated:intent.animated completion:intent.completion];
}

+ (void)dismissWithIntent:(SIPageIntent *)intent {
    [[self rootViewController]dismissViewControllerAnimated:intent.animated completion:intent.completion];
}

+ (void)showPageWith:(SIPageIntent *)intent {
    switch (intent.method) {
        case SIIntentMethodPush:
            [self pushWithIntent:intent];
            break;
        case SIIntentMethodPop:
            [self popWithIntent:intent];
            break;
        case SIIntentMethodPresent:
            [self presentWithIntent:intent];
            break;
        case SIIntentMethodDismiss:
            [self dismissWithIntent:intent];
            break;
        default:
            break;
    }
}

#pragma mark --- 页面管理
+ (void)registerURL:(NSString *)url forIntent:(SIPageIntent *)intent {
    if (!url || url.length == 0 || intent) return;
    [[SIPageManager sharedManager].pathRegister setObject:intent forKey:url];
}

+ (void)deregisterURL:(NSString *)url {
    if (!url || url.length == 0) return;
    [[SIPageManager sharedManager].pathRegister removeObjectForKey:url];
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    if (!url) return NO ;
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    
    // 检查scheme是否匹配
    NSArray *urlTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    NSMutableArray *schemes = [NSMutableArray array];
    for (NSDictionary *dic in urlTypes) {
        NSArray *tmpArray  = dic[@"CFBundleURLSchemes"];
        [schemes addObjectsFromArray:tmpArray];
    }
    
    BOOL match = NO ;
    for (NSString *scheme in schemes) {
        if ([scheme.lowercaseString isEqualToString:components.scheme.lowercaseString]) {
            match = YES;
            break;
        }
    }
    if (!match) return NO;
    
    // 获取页面名
    NSString *name = (!components.path||components.path.length == 0)? components.host : components.path.lastPathComponent;
    SIPageIntent *intent = [[SIPageManager sharedManager].pathRegister objectForKey:name];
    if (!intent) return NO;
    // 获取页面参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSArray *itemStringArray = [components.query componentsSeparatedByString:@"&"];
    for (NSString *itemString in itemStringArray) {
        NSRange range = [itemString rangeOfString:@"="];
        if (range.location != NSNotFound) {
            NSString *key = [itemString substringToIndex:range.location];
            NSString *val = [itemString substringFromIndex:range.location + range.length];
            [params addEntriesFromDictionary:@{key:val}];
        }
    }
    
    intent.parameters = params;
    [self showPageWith:intent];
    return YES;
}

@end
