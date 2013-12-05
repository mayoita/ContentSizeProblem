//
//  CMVGameViewController.m
//  ContentSizeProblem
//
//  Created by Massimo Moro on 05/12/13.
//  Copyright (c) 2013 Massimo Moro. All rights reserved.
//

#import "CMVGameViewController.h"
#import "CMVGameCell.h"

#import "CMVFlipPhoto.h"

#define BOTTOM_PADDING 150.0f
#define cellIdentifier @"GameCell"

#define CN 1
#define VE 0
#define Picture 0
#define Description 1

#define PLAY @"play"
#define PAUSE @"pause"

#define SCROLL_SPEED 1 //items per second, can be negative or fractional


@interface CMVGameViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    bool displayingPrimary;
    BOOL playing;
    bool single;
    bool toRight;
    int scrollStep;
    int widthOfLastImage;
    id standardLayout;
}
//PhotoDB.plist
@property (nonatomic,strong) NSArray *dataSource;



@property(nonatomic, weak) IBOutlet UICollectionView *pictureCollectionView;


@property (nonatomic, strong) NSTimer *scrollTimer;
@property (nonatomic, assign) NSTimeInterval lastTime;

@end

@implementation CMVGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    toRight=true;
    scrollStep=0;
	
    [self.pictureCollectionView registerNib:[UINib nibWithNibName:@"GamePhotoCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellIdentifier];
    
    [self setupDataSource];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(200, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.pictureCollectionView setCollectionViewLayout:flowLayout];
    
}


-(void)setupDataSource {
    NSString *plistName = [NSString stringWithFormat:@"PhotoDBase"];
    NSArray *contentArray = [[NSMutableArray alloc] initWithContentsOfFile:
                             [[NSBundle mainBundle] pathForResource:plistName
                                                             ofType:@"plist"]];
    self.dataSource = contentArray[CN];
    
    
    widthOfLastImage= [UIImage imageNamed:[self.dataSource lastObject][Picture]].size.width;
}



#pragma mark Autoscroll


- (void)startScrolling
{
    [self.scrollTimer invalidate];
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0
                                                        target:self
                                                      selector:@selector(scrollStep)
                                                      userInfo:nil
                                                       repeats:YES];
    
    [self.playPhoto setImage:[UIImage imageNamed:PAUSE] forState:UIControlStateNormal];
    self.playPhoto.titleLabel.text=@"Play";
}

- (void)stopScrolling
{
    [_scrollTimer invalidate];
    _scrollTimer = nil;
    [self.playPhoto setImage:[UIImage imageNamed:PLAY] forState:UIControlStateNormal];
    self.playPhoto.titleLabel.text=@"Pause";
    
}

- (void)scrollStep {

    
    NSLog(@"ContentSize: %f", self.pictureCollectionView.contentSize.width);
    NSLog(@"ContentOffset: %f",  self.pictureCollectionView.contentOffset.x);
    NSLog(@"ContentSize diff: %f",  self.pictureCollectionView.contentSize.width - widthOfLastImage);

    

    if (self.pictureCollectionView.contentOffset.x >= self.pictureCollectionView.contentSize.width - widthOfLastImage) {
        toRight = !toRight;
        float step=self.pictureCollectionView.contentOffset.x-1;
        self.pictureCollectionView.contentOffset = CGPointMake(step, 0);
    } else if (self.pictureCollectionView.contentOffset.x == 0) {
        float step=self.pictureCollectionView.contentOffset.x+1;
        self.pictureCollectionView.contentOffset = CGPointMake(step, 0);
        toRight = !toRight;
    } else if (toRight && self.pictureCollectionView.contentOffset.x > 0) {
        float step=self.pictureCollectionView.contentOffset.x+1;
        self.pictureCollectionView.contentOffset = CGPointMake(step, 0);
    } else if (self.pictureCollectionView.contentOffset.x < 0) {
        self.pictureCollectionView.contentOffset = CGPointMake(0, 0);
        toRight = !toRight;
    }
   
    if (toRight) {
        float step=self.pictureCollectionView.contentOffset.x+1;
        self.pictureCollectionView.contentOffset = CGPointMake(step, 0);
    } else {
        float step=self.pictureCollectionView.contentOffset.x-1;
        self.pictureCollectionView.contentOffset = CGPointMake(step, 0);
    }
    }

- (IBAction)playPhoto:(id)sender {
    !playing?[self startScrolling]:[self stopScrolling];
    playing = !playing;

    
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view
     numberOfItemsInSection:(NSInteger)section {
   
    return [self.dataSource count]; }

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1; }

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CMVGameCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
        cell.delegateForButton=self;
        cell.photo = [UIImage imageNamed:[self.dataSource objectAtIndex:indexPath.item][Picture]];
    
    return cell; }

#pragma mark - UICollectionViewDelegate


-(void)stopAnimationByPhotoTouch {
    
    if (playing) {
        [self stopScrolling];
        playing=!playing;
    }
    
}



#pragma mark – UICollectionViewDelegateFlowLayout
// 1
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *image;
    image = [UIImage imageNamed:self.dataSource[indexPath.row][Picture]];
    
    CGSize retval = image.size.width > 0 ? image.size :CGSizeMake(100, 100);

    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


@end
