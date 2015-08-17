//
//  MainCollectionViewController.m
//  EatOK
//
//  Created by Alfredo Re on 8/15/15.
//  Copyright (c) 2015 StartNode. All rights reserved.
//

#import "MainCollectionViewController.h"
#import "MainCollectionViewStackedLayout.h"
#import "MainCollectionViewExpandedLayout.h"
#import "MainCollectionViewCell.h"

@interface MainCollectionViewController ()

@property (assign, nonatomic) CGPoint itemsContentOffset;

@end

@implementation MainCollectionViewController

MainCollectionViewStackedLayout *stackedLayout;
static NSString * const reuseIdentifier = @"Cell";
NSArray *backgrounds;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
	
	//prepare backgrounds array
	backgrounds = [NSArray arrayWithObjects:@"Breakfast", @"Mid Morning Snack", @"Lunch", @"Afternoon Snack", @"Dinner", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (MainCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
	cell.backgroundColor = [UIColor colorWithRed:.7 green:.1*(long)indexPath.row blue:.3*((long)indexPath.row+1) alpha:1];
	
	UIImage *image = [UIImage imageNamed:backgrounds[indexPath.row]];
	cell.backgroundImage.image = image;
	cell.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
	cell.backgroundImage.backgroundColor = [UIColor blueColor];
	cell.backgroundImage.frame = CGRectMake(0, 0, self.view.frame.size.width, 1000);
	cell.title.text = [backgrounds[indexPath.row] uppercaseString];
	//[cell.title sizeToFit];
	//cell.title.center = self.view.center;
	[cell.title setCenter:CGPointMake(self.view.frame.size.width/2, 100)];
	
    // Configure the cell
	
	if(indexPath.row%2){
		cell.title.font = [UIFont boldSystemFontOfSize:14];
	}else{
		cell.title.font = [UIFont boldSystemFontOfSize:29];
	}
	
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"Selected");
	MainCollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
	// Hide single view.. (when back button pressed)
	if ([indexPath isEqual:self.exposedItemIndexPath]) {
		[cell deSelectedAnimations];
		//self.exposedItemIndexPath = nil;
		//[_delegate didDeSelectItem];
		//
		
		
		//dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.3);
		//dispatch_after(delay, dispatch_get_main_queue(), ^(void){
			//cell.backgroundImage.frame = CGRectMake(0, 0, self.view.frame.size.width, 1000);
		//});
	}
	// Select single view
	else if (self.exposedItemIndexPath == nil) {
		self.exposedItemIndexPath = indexPath;
		[_delegate didSelectItem];
		[cell selectedAnimations];
	}
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark Alfred's methods
- (void)setExposedItemIndexPath:(NSIndexPath *)exposedItemIndexPath
{
	if (![exposedItemIndexPath isEqual:_exposedItemIndexPath]) {
		if (exposedItemIndexPath) {
			_itemsContentOffset = self.collectionView.contentOffset;
			MainCollectionViewExpandedLayout *expandedLayout = [[MainCollectionViewExpandedLayout alloc] initWithExposedItemIndex:exposedItemIndexPath.item];
			[self.collectionView setCollectionViewLayout:expandedLayout animated:YES];
			
		}else{
			stackedLayout = [[MainCollectionViewStackedLayout alloc] init];
			stackedLayout.overwriteContentOffset = YES;
			stackedLayout.contentOffset = self.itemsContentOffset;
			[self.collectionView setCollectionViewLayout:stackedLayout animated:YES];
			[self.collectionView setContentOffset:self.itemsContentOffset animated:YES];
		}
		_exposedItemIndexPath = exposedItemIndexPath;
	}
}

@end
