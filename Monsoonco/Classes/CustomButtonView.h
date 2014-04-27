//
//  CustomButtonView.h
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/25/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButtonView : UIView

@property (nonatomic, strong) EatDataVO *eatDataVO;

- (void)setData:(EatDataVO *)eatDataVO;
- (void)updateLabel:(EatDataVO *)eatDataVO;

@end
