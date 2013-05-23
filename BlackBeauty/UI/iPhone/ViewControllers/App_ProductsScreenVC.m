//
//  App_ProductsScreenVC.m
//  BlackBeauty
//
//  Created by Mahi on 5/20/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "App_ProductsScreenVC.h"

@interface App_ProductsScreenVC ()

@end

@implementation App_ProductsScreenVC
@synthesize productsScrollView,bulletPointsView,thumbNailImage,productInfoView,leftSideButton,rightSideButton,userOptionsTable,imageZoomButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.productsScrollView setContentSize:CGSizeMake(320, 1250)];
    self.productsScrollView.maximumZoomScale = 4.0;
    [self.productsScrollView setClipsToBounds:YES];
    self.productsScrollView.delegate = self;
    [self.productsScrollView setScrollEnabled:YES];
    

    
    
    
    //self.navigationItem.backBarButtonItem = backButton;
    
    //self.navigationController.navigationBar.topItem.leftBarButtonItem.title = @"Products";
    
    self.title = @" BLACK BEAUTY® GLASS";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark action methods

-(IBAction)onImageZoomButtonClicked:(id)sender
{
//    UIImageView* enlargedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, 300, 395)];
//    
//    enlargedImageView.image = [UIImage imageNamed:@"testImage.jpg"];
//    
//    [self.view addSubview:enlargedImageView];
    
    imageFullScreenVC* fullImage = [[imageFullScreenVC alloc] init];
    
    fullImage.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:fullImage animated:YES];
    
    [fullImage release];
    
}


#pragma mark TableView Methods

#pragma mark TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    // NSLog(@"array count is %d",[dataSourceArray count]);
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.; // you can have your own choice, of course
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	DefaultTableCell *cell = (DefaultTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		// Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DefaultTableCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.accessoryView = nil;
	}
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(DefaultTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
     cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_item_bg@2x.png"]] autorelease];
    
    if(indexPath.section == 0)
    {
        cell.optionLabel.text = @"MSDS";
        cell.optionsIcon.image = [UIImage imageNamed:@"word"];
    }
    
    else if(indexPath.section == 1)
    {
        cell.optionLabel.text = @"Specifications";
         cell.optionsIcon.image = [UIImage imageNamed:@"word"];
    }
        
    else
    {
        cell.optionLabel.text = @"Contact US/ Order now";
         cell.optionsIcon.image = [UIImage imageNamed:@"call_us"];
    }
        
}


@end
