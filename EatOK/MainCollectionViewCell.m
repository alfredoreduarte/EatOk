//
//  MainCollectionViewCell.m
//  EatOK
//
//  Created by Alfredo Re on 8/15/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
	
	//_backgroundImage.frame = CGRectMake(0, 0, 200, 500);
}

//Implement custom Nib
- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MainCollectionViewCell" owner:self options:nil];
		
		if ([arrayOfViews count] < 1) {
			return nil;
		}
		
		if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
			return nil;
		}
		
		self = [arrayOfViews objectAtIndex:0];
	}
	return self;
}

#pragma mark Custom Methods
- (void)selectedAnimations{
	[UIView animateWithDuration:0.3 animations:^{
		_backgroundImage.transform = CGAffineTransformMakeRotation(0);
		_backgroundImage.frame = CGRectMake(0, 0, 375, 1000);
	}];
}
- (void)deSelectedAnimations{
	[UIView animateWithDuration:0.3 animations:^{
		_backgroundImage.transform = CGAffineTransformMakeRotation(0);
		_backgroundImage.frame = CGRectMake(0, 0, 375, self.frame.size.height);
	}];
}

@end
