//
//  CMVFlipPhoto.m
//  ContentSizeProblem
//
//  Created by Massimo Moro on 05/12/13.
//  Copyright (c) 2013 Massimo Moro. All rights reserved.
//

#import "CMVFlipPhoto.h"
#define TopPaddingForDescription 15.0f
#define HeightDescription 50.0f
#define WidthDescription 200.0f

@interface CMVFlipPhoto () {
   
}


@property (nonatomic, strong)UIButton *zoomButton;
@end

@implementation CMVFlipPhoto

@synthesize primaryView=_primaryView, secondaryView=_secondaryView, spinTime;

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
    }
    return self;
}


- (void) setPrimaryView:(UIView *)primaryView{

        _primaryView = primaryView;
        self.flipped=false;
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.primaryView setFrame: frame];
        self.primaryView.userInteractionEnabled = YES;
        [self addSubview: self.primaryView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipTouched:)];
        gesture.numberOfTapsRequired = 1;
        [self.primaryView addGestureRecognizer:gesture];
  
    
   
}

- (void) setSecondaryView:(UIView *)secondaryView{
    _secondaryView = secondaryView;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.secondaryView setFrame: frame];
    self.secondaryView.userInteractionEnabled = YES;
    [self addSubview: self.secondaryView];
    [self sendSubviewToBack:self.secondaryView];
    
    //darker view
    UIImageView* shadowImageView = [[UIImageView alloc] initWithFrame:frame];
    shadowImageView.alpha = 0.6;
    shadowImageView.backgroundColor = [UIColor blackColor];
    [self.secondaryView addSubview:shadowImageView];
    
    //add button
    self.zoomButton=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *icon=[UIImage imageNamed:@"zoom_in"];
    self.zoomButton.backgroundColor = [UIColor colorWithPatternImage:icon];
    self.zoomButton.bounds=CGRectMake(0, 0, icon.size.width, icon.size.height);
    [self.secondaryView addSubview:self.zoomButton];
    self.zoomButton.center=CGPointMake(self.superview.frame.size.width/2, self.superview.frame.size.height - self.zoomButton.bounds.size.height);
    
    //add description
    self.description=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WidthDescription, HeightDescription)];
    self.description.center=CGPointMake(self.superview.frame.size.width/2, TopPaddingForDescription);
    self.description.textAlignment=NSTextAlignmentCenter;
    self.description.textColor=[UIColor whiteColor];
    self.description.backgroundColor=[UIColor clearColor];
    [self.secondaryView addSubview:self.description];

    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipTouched:)];
    gesture.numberOfTapsRequired = 1;
    [self.secondaryView addGestureRecognizer:gesture];

}


-(IBAction) flipTouched:(id)sender{
    [self stopScrolling];
    [UIView transitionFromView:(!self.flipped ? self.primaryView : self.secondaryView)
                        toView:(!self.flipped ? self.secondaryView : self.primaryView)
                      duration: spinTime
                       options: (!self.flipped ? UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut : UIViewAnimationOptionTransitionFlipFromRight+UIViewAnimationOptionCurveEaseInOut)
                    completion:^(BOOL finished) {
                        if (finished) {
                            self.flipped = !self.flipped;
                        }
                    }
     ];
}

- (void)stopScrolling
{
    [_photoDelegate stopAnimationByPhotoTouch];
    
}



@end
