//
//  CMVGameCell.m
//  ContentSizeProblem
//
//  Created by Massimo Moro on 05/12/13.
//  Copyright (c) 2013 Massimo Moro. All rights reserved.
//

#import "CMVGameCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation CMVGameCell
@synthesize flipPhoto;

-(void)setPhoto:(UIImage *)photo {
    if (_photo != photo) {
        _photo=photo;
    }
    
        UIImageView *frontPhoto = [[UIImageView alloc] initWithImage:photo];
        
        UIImageOrientation flippedOrientation = UIImageOrientationUpMirrored;
        
        UIImage * flippedImage = [UIImage imageWithCGImage:frontPhoto.image.CGImage scale:frontPhoto.image.scale orientation:flippedOrientation];
        UIImageView *backPhoto = [[UIImageView alloc] initWithImage:flippedImage];
    
    if (!flipPhoto.primaryView) {
        flipPhoto.scrollTimer=self.scrollTimer;
        flipPhoto.photoDelegate=self.delegateForButton;
        flipPhoto.photoCell=self;
        [flipPhoto setPrimaryView: frontPhoto];
        [flipPhoto setSecondaryView: backPhoto];
        [flipPhoto setSpinTime:0.8];
    }

}


@end
