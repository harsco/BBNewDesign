//
//  HomeScreenVC.m
//  BlackBeauty
//
//  Created by Mahi on 4/30/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "HomeScreenVC.h"

@interface HomeScreenVC ()

@end

@implementation HomeScreenVC
@synthesize headerView;
@synthesize privacyButton;

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
    
    //Configure the Navigation Header programatically
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    self.navigationController.navigationItem.title = @"Black Beauty";
//    self.title = @"Black Beauty";
//    
//   self.headerView.topItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Nav_Logo"]];
//    
//    
//    UIImage* image = [UIImage imageNamed:@"grid@2x"];
//    CGRect frameimg = CGRectMake(0, 0, 20, 20);
//    
//    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
//    [button setBackgroundImage:image forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(onBackClick:)
//     forControlEvents:UIControlEventTouchUpInside];
//    [button setShowsTouchWhenHighlighted:YES];
//    
//    UIBarButtonItem *backButton =[[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
//    
//    self.headerView.topItem.leftBarButtonItem = backButton;
    
    //self.headerView.topItem setTitleView:<#(UIView *)#>
    
    //[self.headerView setBackgroundImage:[UIImage imageNamed:@"Nav_Logo"] forBarMetrics:UIBarMetricsDefault];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Button Action Methods

-(IBAction)onFindBBToolClicked:(id)sender
{
    //[[AppStorage getInstance] getAllLocations];
    
    //Push the screen which takes User Inputs for the search
    LocatorToolUserInputVC* userInputVC = [[LocatorToolUserInputVC alloc] init];
    
     userInputVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    //[self.navigationController pushViewController:userInputVC animated:YES];
    
    [self presentModalViewController:userInputVC animated:YES];
    
    [userInputVC release];
    
}
-(IBAction)onContactUsClicked:(id)sender
{
    ContactUs* testContact = [[ContactUs alloc] init];
    
    testContact.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.navigationController pushViewController:testContact animated:YES];
    
    [testContact release];
    
}
-(IBAction)onDownloadSpecSheetClicked:(id)sender
{
    DownloadVC* download = [[DownloadVC alloc] init];
    
    [self.navigationController pushViewController:download animated:YES];
    
    [download release];
}

-(IBAction)onProductsButtonClicked:(id)sender
{
    ProductsListVC* productsScreen = [[ProductsListVC alloc] init];
    
    productsScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:productsScreen animated:YES];
    
    [productsScreen release];
}

-(IBAction)onPrivacyButtonClicked:(id)sender
{
    NSLog(@"Privacy Clicked");
}

@end
