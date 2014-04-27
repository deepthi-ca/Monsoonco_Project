//
//  MainViewController.m
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/25/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import "MainViewController.h"
#import "LaunchPadViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.loadingView startAnimating];
    [self performSelector:@selector(goToLandingPage) withObject:nil afterDelay:0.5];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden = YES;

}

- (void)goToLandingPage {
    [self.loadingView stopAnimating];
    LaunchPadViewController *hvc = [[LaunchPadViewController alloc] initWithNibName:@"LaunchPadViewController" bundle:nil];
    [[self navigationController] pushViewController:hvc animated:YES];
    
}

@end
