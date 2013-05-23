//
//  locationSearchResultsVC.m
//  BlackBeauty
//
//  Created by Mahi on 5/22/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "locationSearchResultsVC.h"

@interface locationSearchResultsVC ()

@end

@implementation locationSearchResultsVC
@synthesize mapView,locationsListView,viewSelectionControl,locationSearchBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithUserPreference:(USERPREFERENCE)userPreference
{
    if(self = [super init])
    {
        userInput = userPreference;
    }
    
    
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    locManagerObj = [[LocationManager alloc] init];
    locManagerObj.delegate = self;
    
   
    [self prepareNavigationBar];
    
    
    if(userInput == MyLocation)
    {
        
        fetchingResultsAlert = [[UIAlertView alloc] initWithTitle:@"Fetching Locations" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        
        UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]
                                            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        loading.frame=CGRectMake(125, 50, 36, 36);
        [loading startAnimating];
        [fetchingResultsAlert addSubview:loading];
        
        [loading release];
        
        [fetchingResultsAlert show];
        
       // [locationsListView setHidden:YES];
        
        [locManagerObj getResellersNearMYLocation];
    }
    else if(userInput == OtherLocation)
    {
        //do not load anything untill user searches..so proces search request
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Action Methods

-(void)prepareNavigationBar
{
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:245.0/255.0 green:132.0/255.0 blue:38.0/255.0 alpha:1];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                            [NSArray arrayWithObjects:@"Map",@"List",
                                             nil]];
    segmentedControl.frame = CGRectMake(160, 7, 128, 31);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
   // [segmentedControl setWidth:35.0 forSegmentAtIndex:0];
    //[segmentedControl setWidth:45.0 forSegmentAtIndex:1];
    
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
   // segmentedControl.momentary = YES;
    segmentedControl.tintColor = self.navigationController.navigationBar.tintColor;
    
    self.navigationItem.titleView = segmentedControl;
    
    [segmentedControl setSelectedSegmentIndex:1];
    
    //[self.navigationController.navigationBar addSubview:segmentedControl];
}


-(void)segmentAction:(UISegmentedControl*)sender
{
   if([locationsDetails count])
   {
        if(sender.selectedSegmentIndex == 0)
        {
            [self reloadMapData];
        }
        
        else if(sender.selectedSegmentIndex == 1)
        {
            [self.locationsListView setHidden:NO];
            [self.mapView setHidden:YES];
            [self.locationsListView reloadData];
        }
   }
    
}



#pragma mark Search Bar Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    // NSLog(@"text is %@",searchBar.text);
    
    [searchBar resignFirstResponder];
    fetchingResultsAlert = [[UIAlertView alloc] initWithTitle:@"Fetching Locations" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loading.frame=CGRectMake(125, 50, 36, 36);
    [loading startAnimating];
    [fetchingResultsAlert addSubview:loading];
    
    [loading release];
    
    [fetchingResultsAlert show];

    [locManagerObj getResellersNearThePlace:searchBar.text];
    
}


#pragma mark Map View Methods


MKCoordinateRegion coordinateRegionForCoordinates(CLLocationCoordinate2D *coords, NSUInteger coordCount) {
    MKMapRect r = MKMapRectNull;
    for (NSUInteger i=0; i < coordCount; ++i) {
        MKMapPoint p = MKMapPointForCoordinate(coords[i]);
        r = MKMapRectUnion(r, MKMapRectMake(p.x, p.y, 0, 0));
    }
    return MKCoordinateRegionForMapRect(r);
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    if(segmentedControl.selectedSegmentIndex == 0)
    [self prepareAnnotatinView];
}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    
}


-(void)reloadMapData
{
    CLLocationCoordinate2D array[5];
    
    CLLocationCoordinate2D tempCoordinate = CLLocationCoordinate2DMake(hotLocation.Latitude, hotLocation.Longitude);
    
    array[0] = tempCoordinate;
    
    for(int i=0;i<[locationsDetails count];i++)
    {
        CLLocationCoordinate2D tempCoordinate = CLLocationCoordinate2DMake([[locationsDetails objectAtIndex:i] Latitude], [[locationsDetails objectAtIndex:i] Longitude]);
        
        array[i+1] = tempCoordinate;
    }
    
    [self.mapView setHidden:NO];
    [self.locationsListView setHidden:YES];
    [self.mapView setRegion:coordinateRegionForCoordinates(array,5)];

}

-(void)prepareAnnotatinView
{
    
    NSMutableArray* annotationArray = [[NSMutableArray alloc] init];
    //
    CLLocationCoordinate2D tempCoordinate = CLLocationCoordinate2DMake(hotLocation.Latitude, hotLocation.Longitude);
    //
    //annotationView.coordinate = &(tempCoordinate);
    
    //[annotationView setCoordinate:&(tempCoordinate)];
    
    
    
//    BBStoreAnnotation* annotationView = [[BBStoreAnnotation alloc] initWithLocation:tempCoordinate];
//    
//    annotationView.title = hotLocation.name;
//    annotationView.subTitle = hotLocation.telephone;
//    annotationView.isUserLocation = YES;
//    
//    [annotationArray addObject:annotationView];
    
    UserLocationAnnotation* userLocationAnnotation = [[UserLocationAnnotation alloc] initWithLocation:tempCoordinate];
    userLocationAnnotation.title = hotLocation.name;
    [annotationArray addObject:userLocationAnnotation];
    
    
    NSLog(@"telephone is %@",hotLocation.name);
   
    for(int i=0;i<[locationsDetails count];i++)
    {
        CLLocationCoordinate2D tempCoordinate = CLLocationCoordinate2DMake([[locationsDetails objectAtIndex:i] Latitude], [[locationsDetails objectAtIndex:i] Longitude]);
        BBStoreAnnotation* annotationView = [[BBStoreAnnotation alloc] initWithLocation:tempCoordinate];
        annotationView.title = [[locationsDetails objectAtIndex:i] name];
        annotationView.subTitle = [[locationsDetails objectAtIndex:i] telephone];
        
        [annotationArray addObject:annotationView];
        
        [annotationView release];
        
    }
    
    
    
//    [mapView removeAnnotation:annotationView];
//    [mapView addAnnotation:annotationView];
    
    [mapView removeAnnotations:annotationArray];
    [mapView addAnnotations:annotationArray];
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if([annotation isKindOfClass:[UserLocationAnnotation class]])
    {
        static NSString *BridgeAnnotationIdentifier = @"userAnnotationIdentifier";
        
        NSLog(@"annotation");
        
        MKPinAnnotationView *pinView =
        (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
        if (pinView == nil)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]
                                                  initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier];
            
            customPinView.pinColor = MKPinAnnotationColorRed;
            customPinView.animatesDrop = NO;
            customPinView.canShowCallout = YES;
            
            // add a detail disclosure button to the callout which will open a new view controller page
            //
            // note: when the detail disclosure button is tapped, we respond to it via:
            //       calloutAccessoryControlTapped delegate method
            //
            // by using "calloutAccessoryControlTapped", it's a convenient way to find out which annotation was tapped
            //
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        
        else
        {
            pinView.annotation = annotation;
        }
        
        return pinView;

    }
    
    else
    {
        static NSString *BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
        
        NSLog(@"annotation");
        
        MKPinAnnotationView *pinView =
        (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
        if (pinView == nil)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]
                                                  initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier];
            
            customPinView.pinColor = MKPinAnnotationColorGreen;
            customPinView.animatesDrop = NO;
            customPinView.canShowCallout = YES;
            
            // add a detail disclosure button to the callout which will open a new view controller page
            //
            // note: when the detail disclosure button is tapped, we respond to it via:
            //       calloutAccessoryControlTapped delegate method
            //
            // by using "calloutAccessoryControlTapped", it's a convenient way to find out which annotation was tapped
            //
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        
        else
        {
            pinView.annotation = annotation;
        }
        
        return pinView;

    }
    
        
    return nil;
    
    
}



#pragma mark TableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count is %d",[locationsDetails count]);
    return [locationsDetails count];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	storeResultsTableCell *cell = (storeResultsTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"storeResultsTableCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];

		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.accessoryView = nil;
	}
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(storeResultsTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.storeName.text = [[locationsDetails objectAtIndex:indexPath.row] name];
    cell.storeAddress.text = [(Location*)[locationsDetails objectAtIndex:indexPath.row] address];
    cell.storeContactNumber.text = [NSString stringWithFormat:@"%@%@",@"Tel:  ",[[(Location*)[locationsDetails objectAtIndex:indexPath.row] telephone] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    
    cell.storeDistance.text = [NSString stringWithFormat:@"%0.2f mi",[[locationsDetails objectAtIndex:indexPath.row] distanceFromInterestedLocation]];
    
}

#pragma mark Location Manager Call Backs

-(void)didFailToGetDesiredLocations:(NSString *)error
{
    //Log errors
    [fetchingResultsAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:@"Error!!!" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [errorAlert show];
    [errorAlert release];
}

-(void)didGetDesiredLocations:(NSMutableArray *)desiredLocationsArray nearLocation:(Location *)location
{
    // NSLog(@"count is %d",[desiredLocationsArray count]);
    hotLocation = [location retain];
    
    [fetchingResultsAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    locationsDetails = [desiredLocationsArray retain];
    
    if(segmentedControl.selectedSegmentIndex == 0)
    {
        [self.locationsListView setHidden:YES];
        [self.mapView setHidden:NO];
        [self reloadMapData];
    }
    else
    {
        [self.locationsListView setHidden:NO];
        [self.mapView setHidden:YES];
        [self.locationsListView reloadData];
        
    }
    
}




@end
