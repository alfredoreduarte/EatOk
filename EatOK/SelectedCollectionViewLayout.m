//
//  SelectedCollectionViewLayout.m
//  EatOK
//
//  Created by Alfredo Re on 8/16/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import "SelectedCollectionViewLayout.h"

@interface SelectedCollectionViewLayout()

@property (nonatomic, strong) NSDictionary *layoutAttributes;

@end

@implementation SelectedCollectionViewLayout

integer_t selectedElementHeight = 50;


- (CGSize)collectionViewContentSize
{
	CGSize contentSize = CGSizeMake([self.collectionView numberOfItemsInSection:0] *selectedElementHeight, self.collectionView.frame.size.height);
	return contentSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
	return 5;
}

- (void)prepareLayout
{
	[self collectionViewContentSize];
	
	NSMutableDictionary *layoutAttributes = [NSMutableDictionary dictionary];
	NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
	for (NSInteger item = 0; item < itemCount; item++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
		UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
		int xAxis = selectedElementHeight*item;
		attributes.frame = CGRectMake(xAxis, 0, selectedElementHeight, selectedElementHeight);
		attributes.zIndex = item;
		layoutAttributes[indexPath] = attributes;
		
	}
	NSLog(@"aca");
	self.layoutAttributes = layoutAttributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	
	NSMutableArray *layoutAttributes = [NSMutableArray array];
	
	[self.layoutAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
		
		if (CGRectIntersectsRect(rect, attributes.frame)) {
			
			[layoutAttributes addObject:attributes];
		}
	}];
	
	return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	return self.layoutAttributes[indexPath];
}

@end