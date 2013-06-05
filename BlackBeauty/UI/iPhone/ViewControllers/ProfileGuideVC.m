//
//  ProfileGuideVC.m
//  BlackBeauty
//
//  Created by Mahi on 6/4/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "ProfileGuideVC.h"

@interface ProfileGuideVC ()

@end

@implementation ProfileGuideVC
@synthesize profileGuideView;

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


#pragma mark TableView Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
        
        NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
        
        ProfileGuideCell *cell = (ProfileGuideCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil) {
            //cell = [[[MyTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
            
            cell = [[[ProfileGuideCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
            
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0, 80.0,tableView.rowHeight)] autorelease];
            [cell addColumn:85];
            //label.tag = LABEL_TAG;
            label.font = [UIFont systemFontOfSize:8.0];
            //label.text = [NSString stringWithFormat:@"%d", indexPath.row];
            label.text = @"Minimum Nozzle Size";//[machineType objectAtIndex:indexPath.row ];
            //label.textAlignment = UITextAlignmentRight;
            label.textColor = [UIColor blueColor];
            label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
            UIViewAutoresizingFlexibleHeight;
            [cell.contentView addSubview:label];
            
            label =  [[[UILabel alloc] initWithFrame:CGRectMake(90.0, 0, 80.0,tableView.rowHeight)] autorelease];
            [cell addColumn:165];
            //label.tag = VALUE_TAG;
            label.font = [UIFont systemFontOfSize:8.0];
            // add some silly value
            //label.text = [NSString stringWithFormat:@"%d", indexPath.row * 4];
            label.text =   @"Extra Fine(30/60)";//[model objectAtIndex:indexPath.row ];
            //label.textAlignment = UITextAlignmentRight;
            label.textColor = [UIColor blueColor];
            label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
            UIViewAutoresizingFlexibleHeight;
            [cell.contentView addSubview:label];
            
            label =  [[[UILabel alloc] initWithFrame:CGRectMake(170.0, 0, 80.0,tableView.rowHeight)] autorelease];
            [cell addColumn:255];
            //label.tag = VALUE_TAG;
            label.font = [UIFont systemFontOfSize:10.0];
            // add some silly value
            //label.text = [NSString stringWithFormat:@"%d", indexPath.row * 4];
            label.text =   @"Extra Fine(30/60)";//[year objectAtIndex:indexPath.row ];
            //label.textAlignment = UITextAlignmentRight;
            label.textColor = [UIColor blueColor];
            label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
            UIViewAutoresizingFlexibleHeight;
            [cell.contentView addSubview:label];
            
        
            
        
        
        
        
}
    
    return cell;
}

@end
