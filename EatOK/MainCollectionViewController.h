//
//  MainCollectionViewController.h
//  EatOK
//
//  Created by Alfredo Re on 8/15/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemSelectionDelegate <NSObject>
	@required
	//- (void) didSelectItemWithData: (NSDictionary *)data atIndex:(NSIndexPath *)indexPath;
	- (void) didSelectItem;
	- (void) didDeSelectItem;
@end

@interface MainCollectionViewController : UICollectionViewController{
	id <ItemSelectionDelegate> delegate;
}

@property (retain) id delegate;

#pragma mark Properties
@property (strong, nonatomic) NSIndexPath *exposedItemIndexPath;

@end
