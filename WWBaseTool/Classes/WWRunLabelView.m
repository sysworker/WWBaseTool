//
//  LWRunLabelView.m
//  WWBaseTool
//
//  Created by wang bowen on 11/08/2020.
//  Copyright (c) 2022 wang bowen. All rights reserved.
//

#import "WWRunLabelView.h"

@interface WWRunLabelView ()

@property (strong ,nonatomic) UILabel *label1;
@property (strong ,nonatomic) UILabel *label2;
@property (weak ,nonatomic ,readonly) UILabel *lastLabel;
@property (assign ,nonatomic) CGFloat space; // 两个label之间间距

@property (strong ,nonatomic ,readonly) CADisplayLink *displayLink;
@property (strong ,nonatomic ,readonly) NSRunLoop *runLoop;
@property (strong ,nonatomic ,readonly) NSString *runLoopMode;
@end

@implementation WWRunLabelView

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    } return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    
    self.clipsToBounds = YES;
    _speed = .5;
    _space = 8.f;
    _runLoop = [NSRunLoop mainRunLoop];
    _runLoopMode = NSRunLoopCommonModes;
    _bottonToTop = NO;
    
    _label1 = [[UILabel alloc] init];
    [self addSubview:_label1];
    
    _label2 = [[UILabel alloc] init];
    [self addSubview:_label2];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self run];
}

- (void)run {
    
    [self destroy];

    if(_bottonToTop){
        _label1.numberOfLines = 0;
        _label2.numberOfLines = 0;
        CGSize textSize = [_label1 sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)];
        _label1.frame = CGRectMake(0, 0, self.frame.size.width, textSize.height);
        if (textSize.height > self.frame.size.height) {
            _label2.hidden = NO;
            _label2.frame = CGRectMake(0, CGRectGetMaxY(_label1.frame) + _space, self.frame.size.width, textSize.height);
            _lastLabel = _label2;
            _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
            [_displayLink addToRunLoop:_runLoop forMode:_runLoopMode];
            _runing = YES;
        } else {
            _label2.hidden = YES;
        }
    }else{
        
        CGSize textSize = [_label1 sizeThatFits:CGSizeMake(MAXFLOAT, self.frame.size.height)];
        if (textSize.width < self.frame.size.width) {
            textSize.width = self.frame.size.width;
        }
        
        _label1.frame = CGRectMake(0, 0, textSize.width, self.frame.size.height);
        if (textSize.width > self.frame.size.width) {
            
            _label2.hidden = NO;
            
            _label2.frame = CGRectMake(CGRectGetMaxX(_label1.frame) + _space, 0, textSize.width, self.frame.size.height);
            _lastLabel = _label2;
            _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
            [_displayLink addToRunLoop:_runLoop forMode:_runLoopMode];
            _runing = YES;
        } else {
            _label2.hidden = YES;
        }
    }
    
}

- (void)update {
    
    // 更新label的位置
    CGRect frame1 = _label1.frame;
    CGRect frame2 = _label2.frame;
    
    if(_bottonToTop){
        if (CGRectGetMaxY(_lastLabel.frame) > self.frame.size.height) {
            frame1.origin.y -= 1.f * (_speed < 0 ? 0 : _speed > 1 ? 1.f : _speed);
            frame2.origin.y -= 1.f * (_speed < 0 ? 0 : _speed > 1 ? 1.f : _speed);
        }
        
        if (CGRectGetMaxY(frame1) < 0) {
            frame1.origin.y = CGRectGetMaxY(frame2) + _space;
            _lastLabel = _label1;
        } else if (CGRectGetMaxY(frame2) < 0) {
            frame2.origin.y = CGRectGetMaxY(frame1) + _space;
            _lastLabel = _label2;
        }
    }else{
        if (CGRectGetMaxX(_lastLabel.frame) > self.frame.size.width) {
            frame1.origin.x -= 1.f * (_speed < 0 ? 0 : _speed > 1 ? 1.f : _speed);
            frame2.origin.x -= 1.f * (_speed < 0 ? 0 : _speed > 1 ? 1.f : _speed);
        }
        
        if (CGRectGetMaxX(frame1) < 0) {
            frame1.origin.x = CGRectGetMaxX(frame2) + _space;
            _lastLabel = _label1;
        } else if (CGRectGetMaxX(frame2) < 0) {
            frame2.origin.x = CGRectGetMaxX(frame1) + _space;
            _lastLabel = _label2;
        }
    }
    
    _label1.frame = frame1;
    _label2.frame = frame2;
}

- (void)destroy; {
    _runing = NO;
    [_displayLink invalidate];
    _displayLink = nil;
}

#pragma mark - setter
- (void)setText:(NSString *)text {
    _text = text; _attributedText = nil;
    
    _label1.attributedText = _attributedText;
    _label1.text = _text;
    
    _label2.attributedText = _attributedText;
    _label2.text = _text;
    
    if (self.superview) {
        [self setNeedsLayout];
    }
}

- (void)setAttributedText:(NSAttributedString *)attributeText {
    _attributedText = attributeText; _text = nil;
    
    _label1.text = _text;
    _label1.attributedText = _attributedText;
    
    _label2.text = _text;
    _label2.attributedText = _attributedText;
    
    if (self.superview) {
        [self setNeedsLayout];
    }
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _label1.font = font;
    _label2.font = font;
    if (self.superview) {
        [self setNeedsLayout];
    }
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _label1.textColor = textColor;
    _label2.textColor = textColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    _label1.textAlignment = _textAlignment;
    _label2.textAlignment = _textAlignment;
    if (self.superview) {
        [self setNeedsLayout];
    }
}

@end
