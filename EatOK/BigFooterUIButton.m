//
//  BigFooterUIButton.m
//  EatOK
//
//  Created by Alfredo Re on 8/16/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import "BigFooterUIButton.h"

@implementation BigFooterUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"BigFooterUIButton" owner:self options:nil];
		
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
