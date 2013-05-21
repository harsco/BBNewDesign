//
//  ProductsListVC.m
//  BlackBeauty
//
//  Created by Mahi on 5/16/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "ProductsListVC.h"

@interface ProductsListVC ()

@end

@implementation ProductsListVC
@synthesize headerView;

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
    
    UIImage* image = [UIImage imageNamed:@"grid@2x"];
    CGRect frameimg = CGRectMake(0, 0, 25, 25);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onBackClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    
    self.headerView.topItem.leftBarButtonItem = backButton;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)onBackClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark button methods
-(IBAction)onBBGlassClicked:(id)sender
{
    App_ProductsScreenVC* productsVC = [[App_ProductsScreenVC alloc] init];
    
    [self presentModalViewController:productsVC animated:YES];
    
}

@end
