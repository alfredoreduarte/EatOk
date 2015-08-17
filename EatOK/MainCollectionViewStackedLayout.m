//
//  MainCollectionViewStackedLayout.m
//  EatOK
//
//  Created by Alfredo Re on 8/15/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import "MainCollectionViewStackedLayout.h"

@interface MainCollectionViewStackedLayout()

@property (nonatomic, strong) NSDictionary *layoutAttributes;

@end

@implementation MainCollectionViewStackedLayout

- (CGSize)collectionViewContentSize
{
	CGSize contentSize = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
	return contentSize;
}

- (void)prepareLayout{
	NSMutableDictionary *layoutAttributes = [NSMutableDictionary dictionary];
	for (NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:0]; item++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
		UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
		//integer_t mainCellHeight = (self.collectionView.frame.size.height*0.7)/3;
		integer_t mainCellHeight = self.collectionView.frame.size.height/5;
		integer_t secondaryCellHeight = (self.collectionView.frame.size.height*0.3)/2;
		//if(item == 0 || item == 2 || item == 4){
			attributes.frame = CGRectMake(0, item*mainCellHeight, self.collectionView.frame.size.width, mainCellHeight+2);
		//}
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
