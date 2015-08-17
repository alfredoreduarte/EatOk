//
//  ViewController.m
//  EatOK
//
//  Created by Alfredo Re on 8/15/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import "ViewController.h"
#import "MainCollectionViewStackedLayout.h"
#import "MenuCollectionViewLayout.h"
#import "SelectedCollectionViewLayout.h"
#import "BigFooterUIButton.h"
#import "TTHorizontalPicker.h"

@interface ViewController ()

@end

@implementation ViewController

UIButton *menuDoneButton;
UIButton *closeButton;
UIScrollView *resultList;
UILabel *explainingLabelOne;
UILabel *explainingLabelTwo;
UILabel *timepickerLabel;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self initMainViewController];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

#pragma mark <ItemSelectionDelegate>
- (void)didSelectItem{
	
	dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.3);
	dispatch_after(delay, dispatch_get_main_queue(), ^(void){
		[self initMenuViewController];
		[self initSelectedViewController];
		[self showMenuDoneButton];
		[self showCloseButton];
	});
}
- (void)didDeSelectItem{
	_menuCollectionViewController.removeFromParentViewController;
	_menuCollectionViewController.view.removeFromSuperview;
	_menuCollectionViewController = false;
	
	_selectedCollectionViewController.removeFromParentViewController;
	_selectedCollectionViewController.view.removeFromSuperview;
	_selectedCollectionViewController = false;
	
	menuDoneButton.removeFromSuperview;
	menuDoneButton = false;
	
	closeButton.removeFromSuperview;
	closeButton = false;
}

#pragma mark <MenuItemSelectionDelegate>
- (void)didSelectMenuItem{
	NSLog(@"menu item");
	[_selectedCollectionViewController.selectedItemsArray addObject:[NSString stringWithFormat:@"agregado"]];
	[_selectedCollectionViewController.collectionView reloadData];
}

#pragma mark Alfred's Methods

- (void)saveMenu{
	NSLog(@"saveeer");
	[resultList removeFromSuperview];
	[explainingLabelOne removeFromSuperview];
	[explainingLabelTwo removeFromSuperview];
	
	[menuDoneButton setTitle:@"SAVE" forState:UIControlStateNormal];
	[menuDoneButton removeTarget:self action:@selector(saveMenu) forControlEvents:UIControlEventTouchUpInside];
	[menuDoneButton addTarget:self action:@selector(saveNotification) forControlEvents:UIControlEventTouchUpInside];
	
	//present timepicker labels
	timepickerLabel = [[UILabel alloc] init];
	timepickerLabel.text = @"NOTIFY ME";
	timepickerLabel.textColor = [UIColor whiteColor];
	timepickerLabel.font = [UIFont boldSystemFontOfSize:9];
	timepickerLabel.sizeToFit;
	[self.view addSubview:timepickerLabel];
	CGSize size = timepickerLabel.superview.frame.size;
	[timepickerLabel setCenter:CGPointMake(self.view.frame.size.width/2, 40)];
	
	//present timepicker
//	NSString *shutterSpeeedValues = [[NSBundle mainBundle] pathForResource:@"ShutterSpeeds" ofType:@"plist"];
//	_timePicker = [[TTHorizontalPicker alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height)];
//	//[_timePicker setDelegate:self];
//	[_timePicker setDataSource:[NSArray arrayWithContentsOfFile:shutterSpeeedValues]];
//	[_timePicker setMinimumValue:[NSNumber numberWithInteger:67]];
//	[_timePicker setMaximumValue:[NSNumber numberWithInteger:600]];
//	[_timePicker setDefaultIndex:1];
//	
//	// Optional - You can change the gradient, horizontal and vertical lines color
//	[_timePicker gradientViewLeftGradientStarColor:[UIColor redColor]];
//	[_timePicker gradientViewLeftGradientEndColor:[UIColor colorWithWhite:1.0 alpha:0.0]];
//	
//	[_timePicker gradientViewRightGradientStarColor:[UIColor redColor]];
//	[_timePicker gradientViewRightGradientEndColor:[UIColor colorWithWhite:1.0 alpha:0.0]];
//	[_timePicker horizontalLinesColor:[UIColor blackColor]];
//	[_timePicker verticalLinesColor:[UIColor blackColor]];
	
	// Change the direction of the gradient
//	[_timePicker gradientDirection:(GradientDirection)TopToBottom];
	
	//timePicker.frame = CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height);
//	[self.view insertSubview:_timePicker aboveSubview:timepickerLabel];
}

- (void)closeMenu{
	[self didDeSelectItem];
	_mainCollectionViewController.exposedItemIndexPath = nil;
}

- (void)doneSelectingMenu{
	NSLog(@"Menu Done");
	_menuCollectionViewController.view.hidden = YES;
	_selectedCollectionViewController.view.hidden = YES;
	[menuDoneButton setTitle:@"SAVE" forState:UIControlStateNormal];
	[menuDoneButton removeTarget:self action:@selector(doneSelectingMenu) forControlEvents:UIControlEventTouchUpInside];
	[menuDoneButton addTarget:self action:@selector(saveMenu) forControlEvents:UIControlEventTouchUpInside];
	
	//add explaining labels
	explainingLabelOne = [[UILabel alloc] init];
	explainingLabelOne.text = @"FOR";
	explainingLabelOne.textColor = [UIColor whiteColor];
	[self.view insertSubview:explainingLabelOne aboveSubview:menuDoneButton];
	explainingLabelOne.font = [UIFont boldSystemFontOfSize:9];
	explainingLabelOne.sizeToFit;
	[explainingLabelOne setCenter:CGPointMake(self.view.frame.size.width/2, 35)];
	
	explainingLabelTwo = [[UILabel alloc] init];
	explainingLabelTwo.text = @"YOU CAN COMBINE";
	explainingLabelTwo.textColor = [UIColor whiteColor];
	[self.view insertSubview:explainingLabelTwo aboveSubview:menuDoneButton];
	explainingLabelTwo.font = [UIFont boldSystemFontOfSize:13];
	explainingLabelTwo.sizeToFit;
	[explainingLabelTwo setCenter:CGPointMake(self.view.frame.size.width/2, 90)];
	
	//add detailed list
	resultList = [[UIScrollView alloc] init];
	resultList.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-55);
	resultList.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
	[self.view insertSubview:resultList belowSubview:menuDoneButton];
	resultList.contentSize = CGSizeMake(self.view.frame.size.width, 110*10);
	UIView *childView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
	childView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
	UIView *childCircle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	childCircle.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.5];
	childCircle.layer.cornerRadius = 20/2;
	childCircle.layer.borderColor = [UIColor whiteColor].CGColor;
	childCircle.layer.borderWidth = 1.5;
	UILabel *childLabel = [[UILabel alloc] init];
	childLabel.text = @"PLACEHOLDER ITEM";
	childLabel.textColor = [UIColor whiteColor];
	childLabel.font = [UIFont boldSystemFontOfSize:15];
	childLabel.sizeToFit;
	[childView addSubview:childLabel];
	[childView addSubview:childCircle];
	[childCircle setCenter:CGPointMake(self.view.frame.size.width/2, 20)];
	[childLabel setCenter:CGPointMake(self.view.frame.size.width/2, 50)];
	
	NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject: childView];
	
	int i = 0;
	while (i<10) {
		UIView *newView = [NSKeyedUnarchiver unarchiveObjectWithData: archivedData];
		newView.frame = CGRectMake(0, 110*i, self.view.frame.size.width, 100);
		[resultList addSubview:newView];
		i++;
	}
}

- (void)showCloseButton{
	closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	closeButton.backgroundColor = [UIColor clearColor];
	[closeButton setImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
	[closeButton setTintColor:[UIColor whiteColor]];
	[closeButton setTitle:@"" forState:UIControlStateNormal];
	closeButton.frame = CGRectMake(10, 10, 16, 16);
	[closeButton addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:closeButton];
}

- (void)showMenuDoneButton{
	menuDoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	menuDoneButton.backgroundColor = [UIColor whiteColor];
	[menuDoneButton setTitle:@"DONE" forState:UIControlStateNormal];
	menuDoneButton.titleLabel.font = [UIFont boldSystemFontOfSize:21];
	[menuDoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	menuDoneButton.frame = CGRectMake(0, self.view.frame.size.height-55, self.view.frame.size.width, 55);
	[menuDoneButton addTarget:self action:@selector(doneSelectingMenu) forControlEvents:UIControlEventTouchUpInside];
	//menuDoneButton.titleLabel.text = @"DONE";
	[self.view addSubview:menuDoneButton];
	NSLog(@"fdsa");
}

- (void)initMainViewController{
	if (!_mainCollectionViewController) {
		MainCollectionViewStackedLayout *mainLayout = [[MainCollectionViewStackedLayout alloc] init];
		_mainCollectionViewController = [[MainCollectionViewController alloc] initWithCollectionViewLayout:mainLayout];
		[_mainCollectionViewController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
		[self.view addSubview:_mainCollectionViewController.view];
		[self addChildViewController:_mainCollectionViewController];
		[_mainCollectionViewController didMoveToParentViewController:self];
		_mainCollectionViewController.delegate = self;
	}
}

- (void)initMenuViewController{
	if (!_menuCollectionViewController) {
		MenuCollectionViewLayout *menuLayout = [[MenuCollectionViewLayout alloc] init];
		_menuCollectionViewController = [[MenuCollectionViewController alloc] initWithCollectionViewLayout:menuLayout];
		[_menuCollectionViewController.view setFrame:CGRectMake(0, 180, self.view.frame.size.width, self.view.frame.size.height-235)];
		[self.view addSubview:_menuCollectionViewController.view];
		[self addChildViewController:_menuCollectionViewController];
		[_menuCollectionViewController didMoveToParentViewController:self];
		_menuCollectionViewController.delegate = self;
		_menuCollectionViewController.view.hidden = NO;
	}
}

- (void)initSelectedViewController{
	if (!_selectedCollectionViewController) {
		SelectedCollectionViewLayout *selectedLayout = [[SelectedCollectionViewLayout alloc] init];
		_selectedCollectionViewController = [[SelectedCollectionViewController alloc] initWithCollectionViewLayout:selectedLayout];
		[_selectedCollectionViewController.view setFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
		[self.view addSubview:_selectedCollectionViewController.view];
		[self addChildViewController:_selectedCollectionViewController];
		[_selectedCollectionViewController didMoveToParentViewController:self];
		//_menuCollectionViewController.delegate = self;
		_selectedCollectionViewController.view.hidden = NO;
	}
}

@end
