//
//  MenuCollectionViewCell.m
//  EatOK
//
//  Created by Alfredo Re on 8/16/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import "MenuCollectionViewCell.h"

@implementation MenuCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

//Implement custom Nib
- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MenuCollectionViewCell" owner:self options:nil];
		
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

@end
