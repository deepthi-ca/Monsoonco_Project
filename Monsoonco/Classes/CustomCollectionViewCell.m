//
//  CustomCollectionViewCell.m
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/26/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "CustomButtonView.h"

@interface CustomCollectionViewCell ()

@end

@implementation CustomCollectionViewCell

- (void)setData:(EatDataVO *)eatDataVO {
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    if(self.customButtonView == nil) {
        self.customButtonView = [[CustomButtonView alloc] initWithFrame:self.bounds];
        [self.customButtonView setData:eatDataVO];

    } else {
        [self.customButtonView updateLabel:eatDataVO];
    }
    
    if(![self.customButtonView superview]) {
        [self.contentView addSubview:self.customButtonView];
    }
    
}

@end
