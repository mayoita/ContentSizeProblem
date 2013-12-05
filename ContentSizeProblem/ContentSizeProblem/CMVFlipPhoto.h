//
//  CMVFlipPhoto.h
//  ContentSizeProblem
//
//  Created by Massimo Moro on 05/12/13.
//  Copyright (c) 2013 Massimo Moro. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CMVFlipPhoto;

@protocol CMVFlipPhotoDelegate <NSObject>


- (void)stopAnimationByPhotoTouch;

@end

@interface CMVFlipPhoto : UIView

@property (nonatomic, retain) UIView *primaryView;
@property (nonatomic, retain) UIView *secondaryView;
@property (nonatomic, retain)UIButton *button;
@property (nonatomic)BOOL flipped;
@property float spinTime;
@property (nonatomic, strong)UILabel *description;

@property (nonatomic)id <CMVFlipPhotoDelegate> photoDelegate;
@property (nonatomic)id photoCell;


@property (nonatomic, strong) NSTimer *scrollTimer;

@end
