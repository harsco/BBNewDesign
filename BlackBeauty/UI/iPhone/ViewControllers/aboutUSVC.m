//
//  aboutUSVC.m
//  BlackBeauty
//
//  Created by Mahi on 4/15/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "aboutUSVC.h"

@interface aboutUSVC ()

@end

@implementation aboutUSVC
@synthesize aboutUsHeader,aboutBBImage,backGroundImage,aboutUsText,aboutUsLabel;

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
    
    //self.title = @"Contact Us";
    
    UIBarButtonItem *backButton =[[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    
    self.aboutUsHeader.tintColor = [UIColor colorWithRed:245.0/255.0 green:132.0/255.0 blue:38.0/255.0 alpha:1];
    
    self.aboutUsHeader.topItem.leftBarButtonItem = backButton;
    
   // self.aboutBBImage.image = [UIImage imageNamed:@"about_us"]; //resizableImageWithCapInsets:UIEdgeInsetsMake(10, 7, 0, 7)];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if(IsRunningTallPhone())
    {
        [self.backGroundImage setFrame:CGRectMake(0, 0, 320, 568)];
        [self.aboutBBImage setFrame:CGRectMake(5, 80, 310, 100)];
        [self.aboutUsLabel setFrame:CGRectMake(24, 190, 273, 21)];
        [self.aboutUsText setFrame:CGRectMake(5, 223, 310, 320)];
        
        self.aboutUsText.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
    }
    else
    {
        //[self.aboutUS setFrame:CGRectMake(5, 50, 310, 90)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Action Methods
-(void)onBackClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)onAboutHarscoClicked:(id)sender
{
    aboutHarscoVC* harscoVC = [[aboutHarscoVC alloc] init];
    harscoVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:harscoVC animated:YES completion:nil];
    
    [harscoVC release];
}

@end
