//
//  UIColor+NE.m
//  NETools
//
//  Created by roder on 2021/10/28.
//

#import "UIColor+NE.h"

@implementation UIColor (NE)
+ (UIColor*)ne_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*)ne_colorWithHex:(NSInteger)hexValue
{
    return [UIColor ne_colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)ne_arndomColor
{

    CGFloat red = arc4random_uniform(256)/ 255.0;

    CGFloat green = arc4random_uniform(256)/ 255.0;

    CGFloat blue = arc4random_uniform(256)/ 255.0;

    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];

    return color;

}

@end
