//
//  BBIronProductInfoVC.m
//  BlackBeauty
//
//  Created by Mahi on 5/29/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "BBIronProductInfoVC.h"

@interface BBIronProductInfoVC ()

@end

@implementation BBIronProductInfoVC

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
	// Do any additional setup after loading the view.
    self.title = @"BLACK BEAUTY® IRON";
    [self.productInfoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grading_iron" ofType:@"html"]isDirectory:NO]]];
    [self.packagingView setText:@"Available in 50lb bags at 60 bags per pallet, Jumbo bags loaded up to 2 tons (4,000lbs) and bulk.  Shrink wrap available. Pre-blended with dust suppressant available upon request"];
     self.thumbNailImage.image = [UIImage imageNamed:BBIRONPRODUCTIMAGE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)onImageZoomButtonClicked:(id)sender
{
    
    imageFullScreenVC* fullImage = [[imageFullScreenVC alloc] initWIthImage:[UIImage imageNamed:BBIRONPRODUCTIMAGE]];
    
    fullImage.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:fullImage animated:YES];
    
    [fullImage release];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        contactUSVC* contactUSScreen = [[contactUSVC alloc] init];
        contactUSScreen.isProducts = YES;
        
        [self.navigationController pushViewController:contactUSScreen animated:YES];
        
        [contactUSScreen release];
    }
}



@end
