//
//  MainViewController.h
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/25/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *welcomeTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *welcomeCopyRightLabel;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) IBOutlet UIImageView *titleImage;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, strong) IBOutlet UIView *saveImage;
@end
