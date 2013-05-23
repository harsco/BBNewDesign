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
    
    rootNavigationController = [[UINavigationController alloc] initWithRootViewController:userInputVC];
    
    rootNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:rootNavigationController animated:YES];
    
    [userInputVC release];
    
}
-(IBAction)onContactUsClicked:(id)sender
{
    ContactUs* testContact = [[ContactUs alloc] init];
    
    rootNavigationController = [[UINavigationController alloc] initWithRootViewController:testContact];
    
    rootNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:rootNavigationController animated:YES];
    
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
   
    
   rootNavigationController = [[UINavigationController alloc] initWithRootViewController:productsScreen];
    
    rootNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:rootNavigationController animated:YES];
    
    [productsScreen release];
    [rootNavigationController release];
}

-(IBAction)onPrivacyButtonClicked:(id)sender
{
    NSLog(@"Privacy Clicked");
}

@end
