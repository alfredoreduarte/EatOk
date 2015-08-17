//
//  MenuCollectionViewController.h
//  EatOK
//
//  Created by Alfredo Re on 8/16/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuItemSelectionDelegate <NSObject>
	@required
	//- (void) didSelectItemWithData: (NSDictionary *)data atIndex:(NSIndexPath *)indexPath;
	- (void) didSelectMenuItem;
@end

@interface MenuCollectionViewController : UICollectionViewController{
	id <MenuItemSelectionDelegate> delegate;
}

@property (retain) id delegate;

@end
