//
//  SelectedCollectionViewLayout.h
//  EatOK
//
//  Created by Alfredo Re on 8/16/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedCollectionViewLayout : UICollectionViewLayout

@property (assign, nonatomic) BOOL overwriteContentOffset;
@property (assign, nonatomic) CGPoint contentOffset;

@end