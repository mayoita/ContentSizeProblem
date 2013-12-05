//
//  CMVGameCell.h
//  ContentSizeProblem
//
//  Created by Massimo Moro on 05/12/13.
//  Copyright (c) 2013 Massimo Moro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMVFlipPhoto.h"
#import <QuartzCore/QuartzCore.h>


@interface CMVGameCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, strong)NSString *descriptionText;

@property (weak, nonatomic) IBOutlet CMVFlipPhoto *flipPhoto;

@property (nonatomic)id delegateForButton;
@property (nonatomic, strong) NSTimer *scrollTimer;


@end
