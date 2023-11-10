//
//  UIColor+Gradient.h
//  syapp
//
//  Created by wang bowen on 2019/3/11.
//  Copyright © 2019 路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///渐变色

@interface UIColor (Gradient)

typedef NS_ENUM(NSInteger, GradientChangeDirection) {
    GradientChangeDirectionLevel, //水平方向渐变
    GradientChangeDirectionVertical, //垂直方向渐变
    GradientChangeDirectionUpwardDiagonalLine, //主对角线方向渐变
    GradientChangeDirectionDownDiagonalLine, //副对角线方向渐变
};

/**
 实现渐变色
 
 @param size 渐变区域的尺寸
 @param direction 渐变方向
 @param startcolor 开始颜色
 @param endColor 结束颜色
 @return 渐变的颜色
 */
+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size
                                     direction:(GradientChangeDirection)direction
                                    startColor:(UIColor*)startcolor
                                      endColor:(UIColor*)endColor;
@end

NS_ASSUME_NONNULL_END
