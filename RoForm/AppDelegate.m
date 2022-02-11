//
//  AppDelegate.m
//  RoForm
//
//  Created by roder on 2022/2/9.
//

#import "AppDelegate.h"
#import "NEFormDemoVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[NEFormDemoVC new]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

+ (UINavigationController *)currentNavgationController {
    // 获取当前导航控制器
    UINavigationController *navigationControoler;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDelegate.window.rootViewController isKindOfClass:UITabBarController.class]) {
        UITabBarController *rootVC = (UITabBarController *)appDelegate.window.rootViewController;
        navigationControoler = (UINavigationController *)rootVC.selectedViewController;
    } else {
        navigationControoler = (UINavigationController *)appDelegate.window.rootViewController;
    }
    NSLog(@"当前导航控制器%@",navigationControoler);
    return navigationControoler;
}

@end
