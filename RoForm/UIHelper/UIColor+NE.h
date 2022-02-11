//
//  UIColor+NE.h
//  NETools
//
//  Created by roder on 2021/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (NE)
+ (UIColor*)ne_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*)ne_colorWithHex:(NSInteger)hexValue;
+ (UIColor *)ne_arndomColor;
@end

NS_ASSUME_NONNULL_END
