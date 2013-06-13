//
//  MSDSVC.m
//  BlackBeauty
//
//  Created by Mahi on 6/3/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "MSDSVC.h"

@interface MSDSVC ()

@end

@implementation MSDSVC
@synthesize downloadLabel1,downloadLabel2,downloadLabel3;

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
    self.title = @"MSDS";
    UIImage* image = [UIImage imageNamed:@"grid@2x"];
    CGRect frameimg = CGRectMake(0, 0, 25, 25);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onBackClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    self.navigationController.navigationBar.topItem.leftBarButtonItem = backButton;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:245.0/255.0 green:132.0/255.0 blue:38.0/255.0 alpha:1];
    
    if([[Utilities getInstance] isFileExists:BBORIGINAL])
    {
        [self.downloadLabel1 setHidden:NO];
    }
    if([[Utilities getInstance] isFileExists:BBGLASS])
    {
        [self.downloadLabel2 setHidden:NO];
    }
    if([[Utilities getInstance] isFileExists:BBIRON])
    {
        [self.downloadLabel3 setHidden:NO];
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

-(IBAction)onMSDSDownloadClicked:(UIButton*)sender
{
    NSLog(@"tag is %d",sender.tag);
    DataSource* dataSource = [[DataSource alloc] init];
    dataSource.delegate = self;
    type = sender.tag;
    
    if(sender.tag == 0)
    {
        if([[Utilities getInstance] isFileExists:BBORIGINAL])
        {
            [self viewDocument];
        }
        else
        {
            fetchingResultsAlert = [[UIAlertView alloc] initWithTitle:@"Downloading File" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            
            UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]
                                                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            loading.frame=CGRectMake(125, 50, 36, 36);
            [loading startAnimating];
            [fetchingResultsAlert addSubview:loading];
            
            [loading release];
            
            [fetchingResultsAlert show];
            
             [dataSource downloadMSDSFileForProduct:BBOriginal];
        }
       
        
    }
    
    else if (sender.tag == 1)
    {
        if([[Utilities getInstance] isFileExists:BBGLASS])
        {
            [self viewDocument];
        }
        else
        {
            fetchingResultsAlert = [[UIAlertView alloc] initWithTitle:@"Downloading File" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            
            UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]
                                                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            loading.frame=CGRectMake(125, 50, 36, 36);
            [loading startAnimating];
            [fetchingResultsAlert addSubview:loading];
            
            [loading release];
            
            [fetchingResultsAlert show];
            [dataSource downloadMSDSFileForProduct:BBGlass];

        }
    }
        
    else if (sender.tag == 2)
    {
        if([[Utilities getInstance] isFileExists:BBIRON])
        {
            [self viewDocument];
        }
        else
        {
            fetchingResultsAlert = [[UIAlertView alloc] initWithTitle:@"Downloading File" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            
            UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]
                                                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            loading.frame=CGRectMake(125, 50, 36, 36);
            [loading startAnimating];
            [fetchingResultsAlert addSubview:loading];
            
            [loading release];
            
            [fetchingResultsAlert show];
            [dataSource downloadMSDSFileForProduct:BBIron];
        }
            
    }
        
    
   

    
}



#pragma mark Class Methods

-(void)viewDocument
{
    if(type == BBOriginal)
    {
        [self.downloadLabel1 setHidden:NO];
        NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
        
        NSLog(@"path for resource is %@",resourceDocPath);
        
        NSString *filePath = [resourceDocPath stringByAppendingPathComponent:BBORIGINAL];
        DocumentViewerVC* pdfViewer = [[DocumentViewerVC alloc] initWithFilePath:filePath];
        [self.navigationController pushViewController:pdfViewer animated:YES];
        
        [pdfViewer release];
    }
    else if(type == BBGlass)
    {
        [self.downloadLabel2 setHidden:NO];
        NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
        
        NSLog(@"path for resource is %@",resourceDocPath);
        
        NSString *filePath = [resourceDocPath stringByAppendingPathComponent:BBGLASS];
        DocumentViewerVC* pdfViewer = [[DocumentViewerVC alloc] initWithFilePath:filePath];
        
        [self.navigationController pushViewController:pdfViewer animated:YES];
        
        [pdfViewer release];
    }
    else if(type == BBIron)
    {
        [self.downloadLabel3 setHidden:NO];
        NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
        
        NSLog(@"path for resource is %@",resourceDocPath);
        
        NSString *filePath = [resourceDocPath stringByAppendingPathComponent:BBIRON];
        DocumentViewerVC* pdfViewer = [[DocumentViewerVC alloc] initWithFilePath:filePath];
        [self.navigationController pushViewController:pdfViewer animated:YES];
        
        [pdfViewer release];
    }
    

}


#pragma mark DataSource Callbacks

-(void)dataSourceDidDownloadFile
{
    [fetchingResultsAlert dismissWithClickedButtonIndex:0 animated:YES];
    
   [self viewDocument];    
    
}

-(void)dataSourceDidFailToDownload:(NSString*)error
{
    //throw error
    
    [Utilities showAlertOKWithTitle:@"Error Downloading File!!!" withMessage:error];
}

@end
