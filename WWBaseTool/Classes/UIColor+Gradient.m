//
//  UIColor+Gradient.m
//  syapp
//
//  Created by wang bowen on 2019/3/11.
//  Copyright © 2019 路. All rights reserved.
//

#import "UIColor+Gradient.h"

@implementation UIColor (Gradient)

+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size
                                     direction:(GradientChangeDirection)direction
                                    startColor:(UIColor*)startcolor
                                      endColor:(UIColor*)endColor
{
    if(CGSizeEqualToSize(size,CGSizeZero) || !startcolor || !endColor)
    {
        return nil;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame=CGRectMake(0,0, size.width, size.height);
    CGPoint startPoint =CGPointZero;
    if (direction == GradientChangeDirectionDownDiagonalLine) {
        startPoint =CGPointMake(0.0,1.0);
    }
    gradientLayer.startPoint = startPoint;
    CGPoint endPoint = CGPointZero;
    switch(direction) {
        case GradientChangeDirectionLevel:
        endPoint =CGPointMake(1.0,0.0);
        break;
        case GradientChangeDirectionVertical:
            endPoint =CGPointMake(0.0,1.0);
        break;
        case GradientChangeDirectionUpwardDiagonalLine:
            endPoint =CGPointMake(1.0,1.0);
        break;
            case GradientChangeDirectionDownDiagonalLine:
            endPoint =CGPointMake(1.0,0.0);
        break;
            default:
        break;
    }
    gradientLayer.endPoint= endPoint;
    gradientLayer.colors=@[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];}
@end
