//
//  CustomButtonView.m
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/25/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import "CustomButtonView.h"

static CGFloat titleTextHeight;

#define TAB_FONT                    [UIFont boldSystemFontOfSize:12.0]
#define TAB_MAX_WIDTH               500.0
#define CIRCLE_RADIUS               50.0
#define ARC_RADIUS                  55.0
#define ARC_GAP_VALUE               10.0

@implementation CustomButtonView {
    UILabel *_label;
    CAShapeLayer *circle;
    CAShapeLayer *outerArc;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setData:(EatDataVO *)eatDataVO {
    self.eatDataVO = eatDataVO;
    [self drawCustomView];
}

- (void)drawRect:(CGRect)rect {
    
}

- (void)drawCustomView {
    [self drawCircle];
    if(self.eatDataVO) {
        [self drawArc:[self.eatDataVO.eatOptions count]];
        [self drawLabel:[self.eatDataVO.eatOptions objectAtIndex:self.eatDataVO.currentEatOption]];
    }
}

- (void)drawCircle {
    circle = [CAShapeLayer layer];
    [self setCircleLayout];
    [[self layer] addSublayer:circle];
}

- (void)setCircleLayout {
    circle.path = [UIBezierPath bezierPathWithRoundedRect:
                   CGRectMake(5.0, 5.0, 2.0 * CIRCLE_RADIUS, 2.0 * CIRCLE_RADIUS) cornerRadius:CIRCLE_RADIUS].CGPath;
    circle.fillColor = [UIColor lightGrayColor].CGColor;
    circle.lineWidth = 1;
    circle.opacity = 0.4;
}

- (void)updateLabel:(EatDataVO *)eatDataVO {
    NSString *label = [eatDataVO.eatOptions objectAtIndex:eatDataVO.currentEatOption];
    NSInteger number = eatDataVO.eatOptions.count;
    
    if(eatDataVO.selected && ANIMATION_ENABLED) {
        [self animateFoodItemCell];
    }
    
    [self setLabelLayout:label];
    [self setCircleLayout];
    [self setArcLayout:number];
    
}


- (void)animateFoodItemCell
{
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowRadius = 10.0f;
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowOffset = CGSizeZero;
    
    [UIView animateWithDuration:0.6f delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAllowUserInteraction  animations:^{
        
        [UIView setAnimationRepeatCount:0.6];
        self.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        
    } completion:^(BOOL finished) {
        self.layer.shadowRadius = 0.0f;
        self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }];
    
}

- (void)drawLabel:(NSString *)label {
    titleTextHeight = [@"A" sizeWithAttributes:
                       @{NSFontAttributeName:TAB_FONT}].height;

    if(_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, TAB_MAX_WIDTH, titleTextHeight)];
    }
    [self setLabelLayout:label];
    if(![_label superview]) {
        [self addSubview:_label];
    }
}

- (void)setLabelLayout:(NSString *)label {
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    _label.text = @"";
    _label.text = [label uppercaseString];
    
    _label.font = TAB_FONT;
    _label.textColor = [UIColor whiteColor];
    [_label sizeToFit];
    
    CGSize mySize = self.bounds.size;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.center = CGPointMake(mySize.width * 0.5, mySize.height * 0.5);
}

- (void)drawArc:(NSUInteger)number {
    outerArc = [CAShapeLayer layer];
    [self setArcLayout:number];
    [[self layer] addSublayer:outerArc];
}

- (void)setArcLayout:(NSUInteger)number {
    outerArc.path = [UIBezierPath bezierPathWithRoundedRect:
                     CGRectMake(0.0, 0.0, 2.0 * ARC_RADIUS, 2.0 * ARC_RADIUS) cornerRadius:ARC_RADIUS].CGPath;
    
    outerArc.fillColor = [UIColor clearColor].CGColor;
    outerArc.strokeColor = [UIColor colorWithRed:0.502 green:0.000 blue:0.251 alpha:1.000].CGColor;
    outerArc.lineWidth = 1;
    
    NSNumber *gapValue = [NSNumber numberWithInt:ARC_GAP_VALUE];
    
    CGFloat circ = 2 * 22 * ARC_RADIUS / 7;
    int val = (circ - [gapValue intValue] * number) / number;
    NSNumber *value = [NSNumber numberWithInt:val];
    outerArc.lineDashPattern = @[value, gapValue];
}


@end
