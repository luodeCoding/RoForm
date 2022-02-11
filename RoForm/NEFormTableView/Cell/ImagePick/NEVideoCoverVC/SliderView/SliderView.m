//
//  SliderView.m
//  NETools
//
//  Created by roder on 2021/1/28.
//  Copyright © 2021 roder. All rights reserved.
//

#import "SliderView.h"

@interface SliderView ()
{
    CGPoint startPoint;
    CGPoint endPoint;
}
@end

@implementation SliderView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch*touch = [touches anyObject];
    startPoint =[touch locationInView:self.superview];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch*touch = [touches anyObject];
         
    endPoint=[touch locationInView:self.superview];
    
    CGFloat x =endPoint.x - startPoint.x;
    
    CGFloat width=CGRectGetWidth(self.superview.frame)/8.0;
  
    if (endPoint.x<=width/2.0) {
        self.center = CGPointMake(width/2.0+0.01, self.center.y);
    }else {
        if (endPoint.x>=CGRectGetWidth(self.superview.frame)-width) {
            self.center = CGPointMake(CGRectGetWidth(self.superview.frame)-width/2.0, self.center.y);
        }else {
            self.center = CGPointMake(self.center.x + x, self.center.y);
        }
    }
    startPoint =endPoint;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    
}

@end
