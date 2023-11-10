//
//  WWRunLabelView.h
//  WWBaseTool
//
//  Created by wang bowen on 11/08/2020.
//  Copyright (c) 2022 wang bowen. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 跑马灯效果
/// 默认开启了点击，继承UIControl，如果挡住点击的控件要把点击关掉
@interface WWRunLabelView : UIControl


/**
 * 设置跑马灯文本
 */
@property (strong ,nonatomic) NSString *text;
@property (strong ,nonatomic) NSAttributedString *attributedText;
@property (strong ,nonatomic) UIFont *font;
@property (strong ,nonatomic) UIColor *textColor;
@property (assign ,nonatomic) NSTextAlignment textAlignment;


/**
 * 获取跑马灯状态
 */
@property (assign ,nonatomic ,readonly) BOOL runing;


/**
 * 跑马灯速度 ,取值范围 0 - 1 ,默认0.5
 */
@property (assign ,nonatomic) float speed;

///从下到上 默认否
@property (nonatomic, assign) bool bottonToTop;
/**
 * 销毁
 */
- (void)destroy;

@end
