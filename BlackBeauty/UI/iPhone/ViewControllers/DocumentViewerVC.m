//
//  DocumentViewerVC.m
//  BlackBeauty
//
//  Created by Mahi on 6/3/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "DocumentViewerVC.h"

@interface DocumentViewerVC ()

@end

@implementation DocumentViewerVC
@synthesize documentViewer,loadingIndicator,isProfileGuide;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isProfileGuide = NO;
    }
    return self;
}


-(id)initWithFilePath:(NSString*)filePath
{
    if(self = [super init])
    {
        filePathToBeRendered = [filePath copy];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(isProfileGuide)
    {
        self.title = @"Profile Guide";
        UIImage* image = [UIImage imageNamed:@"grid"];
        CGRect frameimg = CGRectMake(0, 0, 25, 25);
        
        UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onBackClick:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setShowsTouchWhenHighlighted:YES];
        
        UIBarButtonItem *backButton =[[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
        self.navigationController.navigationBar.topItem.leftBarButtonItem = backButton;
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:245.0/255.0 green:132.0/255.0 blue:38.0/255.0 alpha:1];
        
    }
    
    [self openFile];
}


-(void)viewWillAppear:(BOOL)animated
{
    if(IsRunningTallPhone())
    {
        [self.documentViewer setFrame:CGRectMake(0, 0, 320, 568)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)openFile
{
    [self.loadingIndicator setHidden:NO];
    [self.loadingIndicator startAnimating];
    
    [self.documentViewer loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePathToBeRendered]]];
}

#pragma mark Action Methods
-(void)onBackClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loadingIndicator stopAnimating];
    [self.loadingIndicator setHidden:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.loadingIndicator stopAnimating];
    [self.loadingIndicator setHidden:YES];
    
}

@end
