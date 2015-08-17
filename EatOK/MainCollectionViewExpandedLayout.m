//
//  MainCollectionViewExpandedLayout.m
//  EatOK
//
//  Created by Alfredo Re on 8/16/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import "MainCollectionViewExpandedLayout.h"

@interface MainCollectionViewExpandedLayout ()

@property (assign, nonatomic) NSInteger exposedItemIndex;

@property (nonatomic, strong) NSDictionary *layoutAttributes;

@end

@implementation MainCollectionViewExpandedLayout

- (instancetype)initWithExposedItemIndex:(NSInteger)exposedItemIndex {
	self = [super init];
	if (self) {
		self.exposedItemIndex = exposedItemIndex;
	}
	return self;
}

- (CGSize)collectionViewContentSize
{
	CGSize contentSize = self.collectionView.bounds.size;
	contentSize.height -= self.collectionView.contentInset.top + self.collectionView.contentInset.bottom;
	return contentSize;
}

- (void)prepareLayout
{
	CGSize cardSize = CGSizeMake(
								 CGRectGetWidth(self.collectionView.bounds),
								 CGRectGetHeight(self.collectionView.bounds) - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom);
	NSMutableDictionary *layoutAttributes = [NSMutableDictionary dictionary];
	
	for (NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:0]; item++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
		UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
		if (item < self.exposedItemIndex) {
			//anteriores al expuesto
			attributes.frame = CGRectMake(0, 100*(item-self.exposedItemIndex), cardSize.width, 100);
		} else if (item == self.exposedItemIndex) {
			//elemento expuesto
			attributes.frame = CGRectMake(0, 0, cardSize.width, cardSize.height);
		} else if (item > self.exposedItemIndex + 1) {
			//posteriores al expuesto
			attributes.frame = CGRectMake(0, cardSize.height+100*(item-self.exposedItemIndex-1), cardSize.width, 100);
		}else{
			attributes.frame = CGRectMake(0, cardSize.height, cardSize.width, 100);
		}
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
