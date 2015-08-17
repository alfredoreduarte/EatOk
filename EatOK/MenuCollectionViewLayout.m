//
//  MenuCollectionViewLayout.m
//  EatOK
//
//  Created by Alfredo Re on 8/16/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import "MenuCollectionViewLayout.h"

@interface MenuCollectionViewLayout()

@property (nonatomic, strong) NSDictionary *layoutAttributes;

@end

@implementation MenuCollectionViewLayout

integer_t cellHeight = 75;


- (CGSize)collectionViewContentSize
{
	CGSize contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.bounds), [self.collectionView numberOfItemsInSection:0] *cellHeight);
	return contentSize;
}

- (void)prepareLayout
{
	[self collectionViewContentSize];
	
	NSMutableDictionary *layoutAttributes = [NSMutableDictionary dictionary];
	NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
	for (NSInteger item = 0; item < itemCount; item++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
		UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
		attributes.frame = CGRectMake(0, cellHeight*item, CGRectGetWidth(self.collectionView.bounds), cellHeight);
		attributes.zIndex = item;
		layoutAttributes[indexPath] = attributes;
		
	}
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
