//
//  EatDataVO.h
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/26/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EatDataVO : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSArray *eatOptions;
@property (nonatomic) NSInteger currentEatOption;
@property (nonatomic) BOOL selected;

@end
