//
//  UIHelper.h
//  NETools
//
//  Created by roder on 2020/11/2.
//  Copyright © 2020 roder. All rights reserved.
//
#import <UIKit/UIKit.h>

/*
 屏幕宽高
 SCREEN_WIDTH
 SCREEN_HEIGHT
 获取高度
 StatusBarHeight 状态栏
 NavigationBarHeight 导航栏
 TabBarHeight 标签栏
 NavigationContentTop 导航栏 + 状态栏 等
 见 -> QMUICommonDefines文件
*/


/*
 设置色值
 [UIColor ne_colorWithHex:0xFFFFFF];
 [UIColor ne_colorWithHex:0xFFFFFF alpha:1]
 */

#define MOMENTS_HEADER_HEIGHT 44
#define MOMENTS_VIDEO_HEIGHT (MOMENTS_WIDTH*0.65)
#define MOMENTS_LOCATION_HEIGHT 18
#define MOMENTS_FOOTER_HEIGHT 18

//所有元素默认到两边的距离
#define SIDE_DISTANCE 16
//动态 宽度
#define MOMENTS_WIDTH ([[UIScreen mainScreen] bounds].size.width - (2 * SIDE_DISTANCE))
//动态弹框 宽度
#define MOMENTS_POP_WIDTH ([[UIScreen mainScreen] bounds].size.width - (5 * SIDE_DISTANCE))
//动态 图片间距
#define MOMENTS_IMAGES_SPACE 5
//动态 图片长宽
#define MOMENTS_IMAGE_WIDTH ((MOMENTS_WIDTH - (2 * MOMENTS_IMAGES_SPACE)) / 3)
//动态 4张图片 图片长宽
#define MOMENTS_FOUR_IMAGE_WIDTH ((MOMENTS_WIDTH - (2 * MOMENTS_IMAGES_SPACE)) / 2)
//动态 弹窗图片宽
#define MOMENTS_POP_IMAGE_WIDTH ((MOMENTS_POP_WIDTH - (2 * MOMENTS_IMAGES_SPACE)) / 3)
//动态 CELL间距
#define MOMENTS_CELL_SPACE 12

//标签选择collectionView 标签高度
#define LABELSVIEW_CELL_HEIGHT 32
//标签选择collectionView 标签上下间距
#define LABELSVIEW_CELL_LINESPACE 10
#define LABELSVIEW_CELL_INTERITEMSPACE 22


@interface UIHelper : NSObject

#pragma mark - ///////////////////////公用模块////////////////////////
#pragma mark -  文字
// 主要字体颜色 黑
+ (UIColor*)mainTextColor;
// 特殊字体颜色 黄
+ (UIColor*)specialTextColor;
// 警示字体颜色 橘
+ (UIColor *)waringTextColor;
// 成功字体颜色 绿
+ (UIColor *)successfulTextColor;
// 错误字体颜色 粉
+ (UIColor *)failTextColor;

// 文字灰色
+ (UIColor *)textGrayColor;
// 次要文字灰色
+ (UIColor *)subTextGrayColor;
// 常规文本placeholder 颜色
+ (UIColor *)textPlaceHolderColor;

#pragma mark -  view背景色
// 系统背景颜色
+ (UIColor *)backgroundColor;
// 通用View背景颜色
+ (UIColor *)commonViewBgColor;
// 分割线色
+ (UIColor *)lineViewBgColor;
// 搜索框背景颜色
+ (UIColor *)searchViewBgColor;
// cell的背景色
+ (UIColor *)cellBgColor;

#pragma mark -  按钮
// 按钮背景颜色 红->红->绿
+ (UIColor *)mainButtonBgColor;
// 浅色 按钮背景颜色 红->红->绿
+ (UIColor *)simpleMainButtonBgColor;

#pragma mark -  标签
// 系统主要标签颜色
+ (UIColor *)mainTagColor;
// 系统主要标签 浅色
+ (UIColor *)simpleMainTagColor;
// 次要标签颜色
+ (UIColor *)minorColor;
// 次要标签 浅色
+ (UIColor *)simpleMinorColor;

#pragma mark -  catergory
// catergoryTitleView底部选中 小红条颜色
+ (UIColor *)catergoryTitleViewSelectedColor;
// catergoryTitleView底部选中 字体颜色
+ (UIColor *)catergoryTitleViewSelectedTextColor;

#pragma mark - navigationBar
+ (UIColor *)navigationBarColor;
+ (UIFont *)navigationBarItemFont;
+ (UIColor *)navigationBarTitleColor;

#pragma mark - 状态栏样式
+ (BOOL)statusBarStyleLighting;

#pragma mark - tabBar
+ (UIColor *)tabBarBackgroundColor;
+ (UIColor *)tabBarItemNormalColor;
+ (UIColor *)tabBarItemSelectedColor;

#pragma mark - ///////////////////////其他具体业务模块////////////////////////
#pragma mark - xxx

@end
