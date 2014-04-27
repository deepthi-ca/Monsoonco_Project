//
//  LaunchPadViewController.m
//  Monsoonco
//
//  Created by Deepthi Muthyala on 4/25/14.
//  Copyright (c) 2014 Sahasra. All rights reserved.
//

#import "LaunchPadViewController.h"

#import "GoViewController.h"
#import "CustomCollectionViewCell.h"
#import "Utils.h"
#import "Constants.h"

#define CEL_INSET    30.0
#define CEL_WIDTH    110.0
#define CEL_HEIGHT   110.0
#define BLUR_OVERLAY_TAG    -323

@interface LaunchPadViewController ()

@end

@implementation LaunchPadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;

    [self buildData];
    [self addToolbarButtons];
    [self.gridView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
}

- (void)buildData {
    NSArray *arr1 = [NSArray arrayWithObjects:@"one of a kind", @"small batch", @"large batch", @"mass market", nil];
    NSArray *arr2 = [NSArray arrayWithObjects:@"savory", @"sweet", @"umami", nil];
    NSArray *arr3 = [NSArray arrayWithObjects:@"spicy", @"mild", nil];
    NSArray *arr4 = [NSArray arrayWithObjects:@"crunchy", @"mushy", @"smooth", nil];
    NSArray *arr5 = [NSArray arrayWithObjects:@"a little", @"a lot", nil];
    NSArray *arr6 = [NSArray arrayWithObjects:@"breakfast", @"brunch", @"lunch", @"snack", @"dinner", nil];
    
    
    self.eatData = [NSArray arrayWithObjects:
                    [self createEatOptionVO:arr1 uuid:@"uuid1"],
                    [self createEatOptionVO:arr2 uuid:@"uuid2"],
                    [self createEatOptionVO:arr3 uuid:@"uuid3"],
                    [self createEatOptionVO:arr4 uuid:@"uuid4"],
                    [self createEatOptionVO:arr5 uuid:@"uuid5"],
                    [self createEatOptionVO:arr6 uuid:@"uuid6"], nil];
    
}

- (EatDataVO *)createEatOptionVO:(NSArray *)eatArray uuid:(NSString *)uuid {
    EatDataVO *vo = [[EatDataVO alloc] init];
    vo.uuid = uuid;
    vo.eatOptions = eatArray;
    vo.currentEatOption = 0;
    vo.selected = NO;
    return vo;
}

- (void)reloadData {
    [self.gridView reloadData];
}

# pragma mark - Custom Buttons

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self eatData] count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [self getCustomCollectionViewCell:collectionView cellForItemAtIndexPath:indexPath];
    [cell setData:[self.eatData objectAtIndex:indexPath.row]];
    return cell;
}

# pragma mark - Private methods

- (CustomCollectionViewCell *)getCustomCollectionViewCell:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CustomCollectionViewCell";
    
	CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
	if ( cell == nil ) {
        cell = [Utils loadFirstViewFromNibName:cellIdentifier bundle:nil];
	}
    cell.backgroundColor = [UIColor clearColor];
    cell.selected = YES;
    return cell;
    
}

# pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CEL_WIDTH, CEL_HEIGHT);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CEL_INSET, CEL_INSET, CEL_INSET, CEL_INSET);
}

-(void)collectionView:(UICollectionViewCell *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EatDataVO *eatDataVO = [self.eatData objectAtIndex:indexPath.row];
    EatDataVO *nextIndexEatDataVO =  [self getNextIndexObject:eatDataVO];
    [self replaceObjectWith:nextIndexEatDataVO atIndex:indexPath.row];

    for (EatDataVO *vo in self.eatData) {
        if([vo.uuid isEqualToString:nextIndexEatDataVO.uuid]) {
            vo.selected = YES;
        } else {
            vo.selected = NO;
        }
    }
    if(ANIMATION_ENABLED) {
        [self playSound];
    }
    [self reloadData];
}

- (EatDataVO *)getNextIndexObject:(EatDataVO *)eatDataVO {
    NSArray *arr = eatDataVO.eatOptions;
    NSInteger currentIndex = eatDataVO.currentEatOption;
    NSInteger nextIndex = currentIndex + 1;
    if(nextIndex == [arr count]) {
        nextIndex = 0;
    }
    eatDataVO.currentEatOption = nextIndex;
    return eatDataVO;
}

- (EatDataVO *)getRandomIndexObject:(EatDataVO *)eatDataVO {
    NSArray *arr = eatDataVO.eatOptions;
    NSInteger randomIndex = 0 + rand() % (arr.count - 0);
    eatDataVO.currentEatOption = randomIndex;
    eatDataVO.selected = YES;
    return eatDataVO;
}

- (void)replaceObjectWith:(EatDataVO *)newVO atIndex:(NSInteger)atIndex {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.eatData];
    [mutableArray replaceObjectAtIndex:atIndex withObject:newVO];
    self.eatData = mutableArray;
}

# pragma mark - Toolbar buttons

- (void)addToolbarButtons {
    
    UIBarButtonItem *searchButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MONSearchIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(navBarButtonClicked:)];
    UIBarButtonItem *calendarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_calendarIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(navBarButtonClicked:)];
    UIBarButtonItem *compassButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_compassIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(navBarButtonClicked:)];

    NSMutableArray *leftButtons = [[NSMutableArray alloc] initWithObjects:searchButtonItem, calendarButtonItem, compassButtonItem, nil];
    self.navigationItem.leftBarButtonItems = leftButtons;
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_menuIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(navBarButtonClicked:)];
    self.navigationItem.rightBarButtonItem = menuButtonItem;
}

- (IBAction)navBarButtonClicked:(id)sender {
    NSLog(@" navBarButtonClicked ");
}

# pragma mark - Button Actions

- (IBAction)goButtonAction:(id)sender {
    GoViewController *goViewController = [[GoViewController alloc] initWithNibName:@"GoViewController" bundle:nil];
    NSString *resultData = @"Eat Options Selected : \n\n";
    NSInteger i = 1;
    for (EatDataVO *vo in self.eatData) {
        NSString *str = [vo.eatOptions objectAtIndex:vo.currentEatOption];
        resultData = [resultData stringByAppendingString:[NSString stringWithFormat:@"%d) %@ \n", i, str]];
        i++;
    }
    [goViewController setData:resultData];
    [[self navigationController] pushViewController:goViewController animated:YES];
}

- (IBAction)shuffleButtonAction:(id)sender {
    if(ANIMATION_ENABLED) {
        [self playSound];
    }
    for (NSInteger i = 0; i < self.eatData.count; i++) {
        EatDataVO *randomIndexEatDataVO = [self getRandomIndexObject:[self.eatData objectAtIndex:i]];
        [self replaceObjectWith:randomIndexEatDataVO atIndex:i];
    }
    [self reloadData];
}

# pragma mark - Animation and Sound

- (void)blurForDuration:(NSTimeInterval)duration
               view:(UIView *)view
               animated:(BOOL)animated {
    
    [self removeBlurOverlayAfterDelay:0 view:view animated:NO];
    
    // add image
    UIImageView *overlay = [[UIImageView alloc] initWithFrame:view.bounds];
    overlay.tag = BLUR_OVERLAY_TAG;                         // allow easy removal
    overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlay.alpha = animated ? 0.0 : 1.0;
    [view addSubview:overlay];
    
    UIImage *thisImage = [UIImage imageNamed:@"MONLaunchPadBackground.png"];
    overlay.image = thisImage;
    
    if (animated) {
        [UIView animateWithDuration:duration / 2.0
                         animations:^{
                             overlay.alpha = 1.0;
                         } completion:nil];
    }
    
    if (duration > 0) {
        [self removeBlurOverlayAfterDelay:duration
                                     view:view
                                 animated:animated];
    }
    
}

- (void)removeBlurOverlayAfterDelay:(NSTimeInterval)delay
                               view:(UIView *)view
                           animated:(BOOL)animated {
    
    UIImageView *overlayToRemove = (UIImageView*)[view viewWithTag:BLUR_OVERLAY_TAG];
    if (overlayToRemove == nil || ! [overlayToRemove isKindOfClass:[UIImageView class]]) {
        return;
    }
    
    if (animated) {
        [UIView animateWithDuration:delay / 2.0
                              delay:delay / 2.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             overlayToRemove.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [overlayToRemove removeFromSuperview];
                         }];
    } else {
        [overlayToRemove performSelector:@selector(removeFromSuperview)
                              withObject:nil
                              afterDelay:delay];
    }
    
}

- (void)playSound {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"animation_sound" ofType:@"mp3"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    self.avPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
    [self.avPlayer play];
}

@end
