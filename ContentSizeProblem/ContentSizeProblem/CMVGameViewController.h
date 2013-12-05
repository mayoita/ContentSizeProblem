//
//  CMVGameViewController.h
//  ContentSizeProblem
//
//  Created by Massimo Moro on 05/12/13.
//  Copyright (c) 2013 Massimo Moro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMVFlipPhoto.h"


@interface CMVGameViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CMVFlipPhotoDelegate>

@property (weak, nonatomic) IBOutlet UIButton *playPhoto;



@end
