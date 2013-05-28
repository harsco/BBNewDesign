//
//  LocationDetailsVC.m
//  BlackBeauty
//
//  Created by Mahi on 5/24/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "LocationDetailsVC.h"

@interface LocationDetailsVC ()

@end

@implementation LocationDetailsVC
@synthesize storeName,storeStreet,storeCity,userOptionsTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithLocation:(Location*)location
{
    if(self = [super init])
    {
        
        NSLog(@"location is %@",location.name);
        locationToShow = [location retain];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Location Details";
    
    self.storeName.text = locationToShow.name;
    self.storeStreet.text = locationToShow.streetAddress;
    self.storeCity.text = [locationToShow.city stringByAppendingFormat:@"%@%@",@", ",locationToShow.stateAndZip];
    //self.storeCity.text = locationToShow.c
}

-(void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    RELEASE_TO_NIL(storeCity);
    RELEASE_TO_NIL(storeName);
    RELEASE_TO_NIL(storeStreet);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Table View Methods


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	contactUSCell *cell = (contactUSCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		// Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"contactUSCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
		//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		//cell.accessoryView = nil;
	}
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
}



//- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
//   // cell.contentView.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:219.0/255.0 blue:209.0/255.0 alpha:1];
//    //cell.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:219.0/255.0 blue:209.0/255.0 alpha:1];
//    
//    UIImageView* accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(308, 20, 11, 17)];
//    accessoryView.image = [UIImage imageNamed:@"arrow"];
//    [cell addSubview:accessoryView];
//    
//    if(indexPath.row%2 != 0)
//    {
//          cell.contentView.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:219.0/255.0 blue:209.0/255.0 alpha:1];
//    }
//    else
//    {
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//    }
//    
//    
//    cell.backgroundColor = [UIColor clearColor];
//    [cell setBackgroundView:nil];
//
//    
//    cell.textLabel.text = @"Test Location"; //cell.textLabel.text = @"mahi";
//    cell.imageView.image = [UIImage imageNamed:@"directions"];
//}

- (void)configureCell:(contactUSCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row%2 != 0)
    {
        cell.contentView.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:219.0/255.0 blue:209.0/255.0 alpha:1];
    }
    else
    {
        
    }

    if(indexPath.row == 0)
    {
        cell.cellLabel.text = @"Hours";
        cell.cellIcon.image = [UIImage imageNamed:@"clock"];
    }
    
    else if(indexPath.row == 1)
    {
        cell.cellLabel.text = @"Get Directions";
        cell.cellIcon.image = [UIImage imageNamed:@"directions"];
    }
    
    else if(indexPath.row == 2)
    {
        cell.cellLabel.text = [NSString stringWithFormat:@"%@%@",@"Call ",locationToShow.telephone];
        cell.cellIcon.image = [UIImage imageNamed:@"call_us"];
    }
    else if(indexPath.row == 3)
    {
        cell.cellLabel.text = @"View On Map";
        cell.cellIcon.image = [UIImage imageNamed:@"mapViewIcon"];
    }
    else
    {
        cell.cellLabel.text = @"Email";
        cell.cellIcon.image = [UIImage imageNamed:@"email"];
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2)
    {
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            
            NSString* telePhone = [locationToShow.telephone stringByReplacingOccurrencesOfString:@" " withString:@""];
            
           // Removing any unwanted characters in the Telephone Number
            NSString * strippedNumber = [telePhone stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [telePhone length])];
            
            NSLog(@"telephone number is %@",strippedNumber);
            
           // NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"telprompt://",[telePhone stringByReplacingOccurrencesOfString:@"-" withString:@""]]];
            
             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"telprompt://",strippedNumber]];
            
           // NSLog(@"number is %@",[NSString stringWithFormat:@"%@%@",@"telprompt://",[telePhone stringByReplacingOccurrencesOfString:@"-" withString:@""]]);
            [[UIApplication sharedApplication] openURL:url];
        } else {
            UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [Notpermitted show];
            [Notpermitted release];
        }

    }
    
    else if(indexPath.row == 1)
    {
        //Also include < iOS 6 mechanism Very important
        
        NSDictionary *address = @{
                                  (NSString *)kABPersonAddressStreetKey: locationToShow.streetAddress,
                                  (NSString *)kABPersonAddressCityKey: locationToShow.city,
                                  (NSString *)kABPersonAddressStateKey: locationToShow.state,
                                  (NSString *)kABPersonAddressZIPKey: locationToShow.zipCode,
                                  (NSString *)kABPersonAddressCountryCodeKey: @"US"
                                  };
        
        
        
        MKPlacemark* placeMarkEndPoint = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(locationToShow.Latitude, locationToShow.Longitude) addressDictionary:address];
        
        
        MKMapItem* itemForMap = [[[MKMapItem alloc] initWithPlacemark:placeMarkEndPoint] autorelease];
        itemForMap.name = locationToShow.name;
        
         //to test driving distance providing 2 locations in production just need one location user location gets picked automatically as starting point
          MKPlacemark* placeMarkStartPoint = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(40.878082, -74.137878) addressDictionary:nil];
        
        MKMapItem* secondItemForMap = [[[MKMapItem alloc] initWithPlacemark:placeMarkStartPoint] autorelease];
        
        [ MKMapItem openMapsWithItems:[NSArray arrayWithObjects:itemForMap,secondItemForMap, nil] launchOptions:[NSDictionary dictionaryWithObjectsAndKeys:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsDirectionsModeKey, nil]];
        
        
        //[itemForMap openInMapsWithLaunchOptions:[NSDictionary dictionaryWithObjectsAndKeys:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsDirectionsModeKey, nil]];
    }
    else if(indexPath.row == 4)
    {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        
         [mailController setSubject:@"Black Beauty"];
        // [mailController setMessageBody:@"my message" isHTML:NO];
        [mailController setToRecipients:[NSArray arrayWithObjects:@"harscosocialmedia@harsco.com", nil]];
        
        mailController.mailComposeDelegate = self;
        
        
        if ( mailController != nil ) {
            if ([MFMailComposeViewController canSendMail]){
                [self presentModalViewController:mailController animated:YES];
            }
        }
        
        [mailController release];
    }
}

#pragma mark Mail Composer Delegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    [controller dismissModalViewControllerAnimated:YES];
    
}


@end
