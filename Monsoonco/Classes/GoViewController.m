//
//  GoViewController.m
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/26/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import "GoViewController.h"

@interface GoViewController ()

@property (nonatomic, strong) NSString *eatOptionsMessage;

@end


@implementation GoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.resultLabel.text = _eatOptionsMessage;

}

- (void)setData:(NSString *)message {
    _eatOptionsMessage = [message uppercaseString];
}




@end
