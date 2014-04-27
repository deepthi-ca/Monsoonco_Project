//
//  GoViewController.h
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/26/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface GoViewController : MasterViewController

@property (nonatomic, strong) IBOutlet UITextView *resultLabel;

-(void)setData:(NSString *)message;

@end
