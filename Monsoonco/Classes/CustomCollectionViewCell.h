//
//  CustomCollectionViewCell.h
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/26/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButtonView.h"

@interface CustomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) CustomButtonView *customButtonView;

- (void)setData:(EatDataVO *)eatDataVO;

@end
