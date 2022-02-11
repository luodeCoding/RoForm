//
//  AppDelegate.h
//  RoForm
//
//  Created by roder on 2022/2/9.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow * _Nullable window;
/* 获取当前导航控制器 */
+ (UINavigationController *_Nullable)currentNavgationController;
@end

