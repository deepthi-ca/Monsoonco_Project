//
//  LaunchPadViewController.h
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/25/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioSession.h>

#import "MasterViewController.h"

@interface LaunchPadViewController : MasterViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *gridView;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIImageView *randomButonImageView;
@property (nonatomic, strong) IBOutlet UIImageView *goButtonImageView;

@property (nonatomic, strong) NSArray *eatData;
@property (nonatomic) BOOL displayingFront;
@property (nonatomic, strong) AVAudioPlayer *avPlayer;

- (IBAction)goButtonAction:(id)sender;
- (IBAction)shuffleButtonAction:(id)sender;

@end
