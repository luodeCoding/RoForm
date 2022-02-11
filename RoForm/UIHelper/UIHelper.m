//
//  UIHelper.m
//  NETools
//
//  Created by roder on 2020/11/2.
//  Copyright © 2020 roder. All rights reserved.
//

#import "UIHelper.h"
#import <QMUIKit/QMUIKit.h>
#import "UIColor+NE.h"

@implementation UIHelper

#pragma mark - ///////////////////////公用模块////////////////////////
/* 注意：
 通用黑: 262626 (主要是字体用)
 通用红: B01D36 ----------- (365A40 // Other主题颜色 暂时没用)
 系统背景色: F6F7F9
 
 辅助色
 特殊文字: FFB839
 警示文字: FF823A
 成功文字: 00CD00
 错误文字: FF5257
 
 通用灰: AAAAAA 999999 666666
 
 
 
 例如: 黑->xx->xx
 */

#pragma mark -  文字
// 通用黑 主要字体颜色
+ (UIColor*)mainTextColor {
    return [UIColor ne_colorWithHex:0x262626];
}

// 特殊字体颜色 黄
+ (UIColor*)specialTextColor {
    return [UIColor ne_colorWithHex:0xFFB839];
}

// 警示字体颜色 橘
+ (UIColor *)waringTextColor {
    return [UIColor ne_colorWithHex:0xFF823A];
}

// 成功字体颜色 绿
+ (UIColor *)successfulTextColor {
    return [UIColor ne_colorWithHex:0x00CD00];
}

// 错误字体颜色 粉
+ (UIColor *)failTextColor {
    return [UIColor ne_colorWithHex:0xFF5257];
}

// 文字灰色
+ (UIColor *)textGrayColor {
    return [UIColor ne_colorWithHex:0x999999];
}

// 次要文字灰色
+ (UIColor *)subTextGrayColor {
    return [UIColor ne_colorWithHex:0x666666];
}

// 输入框占位文字颜色 placeholder
+ (UIColor *)textPlaceHolderColor {
    return [UIColor ne_colorWithHex:0xAAAAAA];
}

#pragma mark - view背景色
// 系统背景颜色
+ (UIColor *)backgroundColor {
    return [UIColor ne_colorWithHex:0xF6F7F9];
}

// 通用View背景颜色  默认白色底
+ (UIColor *)commonViewBgColor {
    return [UIColor whiteColor];
}

// 分割线色
+ (UIColor*)lineViewBgColor {
    return [UIColor ne_colorWithHex:0x000000 alpha:0.1];
}

// 搜索框背景颜色
+ (UIColor *)searchViewBgColor {
    return [UIColor ne_colorWithHex:0xF5F5F5];
}

// cell的背景色 注：背景在默认的时候为 白色
+ (UIColor *)cellBgColor{
    return [UIColor whiteColor];
}

#pragma mark - 按钮
// 按钮背景颜色 红->红->绿
+ (UIColor *)mainButtonBgColor {
    return [UIColor ne_colorWithHex:0xB01D36];
}

// 浅色 按钮背景颜色 浅红->浅红->浅绿
+ (UIColor *)simpleMainButtonBgColor {
    return [UIColor ne_colorWithHex:0xB01D36 alpha:0.5];
}

#pragma mark - 标签
// 系统主要标签颜色
+ (UIColor *)mainTagColor {
    return [UIColor ne_colorWithHex:0xB01D36];
}

// 系统主要标签 浅色
+ (UIColor *)simpleMainTagColor {
    return [UIColor ne_colorWithHex:0xB01D36 alpha:0.1];
}

// 次要标签颜色
+ (UIColor *)minorColor {
    return [UIColor ne_colorWithHex:0xD7730B];
}

// 次要标签浅色
+ (UIColor *)simpleMinorColor {
    return [UIColor ne_colorWithHex:0xD7730B alpha:0.15];
}

#pragma mark - catergory
// catergoryTitleView底部选中 小条颜色
+ (UIColor *)catergoryTitleViewSelectedColor {
    return [UIColor ne_colorWithHex:0xB01D36];
}

// catergoryTitleView选中 字体颜色 黑->白->绿
+ (UIColor *)catergoryTitleViewSelectedTextColor {
    return [UIColor ne_colorWithHex:0x262626];
}

#pragma mark - 导航栏
// 导航栏背景 颜色
+ (UIColor *)navigationBarColor {
    return [UIColor ne_colorWithHex:0x546279];
}
// 导航栏字体
+ (UIFont *)navigationBarItemFont {
    return [UIFont fontWithName:@"PingFangSC-Regular" size:14];
}
// 导航栏标题颜色
+ (UIColor *)navigationBarTitleColor {
    return [UIColor whiteColor];
}

#pragma mark - 状态栏
// 状态栏样式
+ (BOOL)statusBarStyleLighting {
    return YES;
}

#pragma mark - 底部TabBar
// 背景色
+ (UIColor *)tabBarBackgroundColor {
    return [UIColor ne_colorWithHex:0x292D2C];
}
// 底部TabBarItem未选中色
+ (UIColor *)tabBarItemNormalColor {
    return [UIColor grayColor];
}
// 底部TabBarItem选中色
+ (UIColor *)tabBarItemSelectedColor {
    return [UIColor whiteColor];
}

#pragma mark - ///////////////////////其他具体业务模块////////////////////////
#pragma mark - xxx相关


@end
