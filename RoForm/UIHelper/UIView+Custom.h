//
//  UIView+Custom.h
//  TXCar
//
//  Created by shaneochen on 2018/8/2.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+NE.h"

@interface UIView (ViewFrameGeometry)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property CGFloat x;
@property CGFloat y;

@property CGPoint topCenter;
@property CGPoint leftCenter;
@property CGPoint bottomCenter;
@property CGPoint rightCenter;

//设置渐变色
- (void)setGradientLayer:(UIColor*)startColor endColor:(UIColor*)endColor;
//设置某个方向或者某几个方向的圆角
- (void)setCornerByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
/* 设置边框线*/
- (void)border:(UIColor *)color width:(CGFloat)width;
/* 设置阴影*/
- (void)defalutShadow;
/*防止多次点击*/
-(void)safeEdit:(UIButton *)btn;

/** 可视化设置圆角 */
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
/** 可视化设置裁剪*/
@property (nonatomic, assign)IBInspectable BOOL masksToBounds;
/** 可视化设置圆形*/
@property (nonatomic, assign)IBInspectable BOOL round;

/** 可视化设置阴影*/
@property (nonatomic, assign)IBInspectable BOOL shadow;

/** 可视化设置边框宽度*/
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;

/** 可视化设置边框颜色*/
@property (nonatomic, assign)IBInspectable UIColor *borderColor;

/** 可视化设置渐变色*/ // 格式： FFFFFF,001100,v  第一个色 第二个色 方向：v垂直 h水平
@property (nonatomic, assign)IBInspectable NSString *gradientConfig;

@end


