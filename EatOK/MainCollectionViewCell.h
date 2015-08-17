//
//  MainCollectionViewCell.h
//  EatOK
//
//  Created by Alfredo Re on 8/15/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell

#pragma mark Properties
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *title;

#pragma mark Methods
- (void)selectedAnimations;
- (void)deSelectedAnimations;

@end
