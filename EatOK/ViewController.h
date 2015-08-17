//
//  ViewController.h
//  EatOK
//
//  Created by Alfredo Re on 8/15/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCollectionViewController.h"
#import "MenuCollectionViewController.h"
#import "SelectedCollectionViewController.h"

@interface ViewController : UIViewController <ItemSelectionDelegate, MenuItemSelectionDelegate>


#pragma mark Properties
@property (strong, nonatomic) MainCollectionViewController *mainCollectionViewController;
@property (strong, nonatomic) MenuCollectionViewController *menuCollectionViewController;
@property (strong, nonatomic) SelectedCollectionViewController *selectedCollectionViewController;

@end

