//
//  LocationManager.m
//  BlackBeauty
//
//  Created by Mahi on 4/30/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager
@synthesize locationManager;
@synthesize delegate;



-(void)getResellersNearMYLocation
{
    if([CLLocationManager locationServicesEnabled] == NO)
    {
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled. If you proceed, you will be asked to confirm whether location services should be reenabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
        [servicesDisabledAlert release];
        
        
        locationManager = [[CLLocationManager alloc] init];
        
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
        
    }
    else{
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
        
    }

}

-(NSMutableArray*)getAllLocations
{
    return [[AppStorage getInstance] getAllLocations];
}



-(void)getResellersNearThePlace:(NSString*)place
{
    
    //special flow for Pincode as it produces accurate results
    
    if([self isStringNumeric:place])
    {
        place = [place stringByAppendingFormat:@"%@",@",United States"];
    }
    
    [self doForwardGeoCodingOfPlace:place];
    
}

-(BOOL)isStringNumeric:(NSString*)string
{
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber * goodNumber = [nf numberFromString:string];
    
    if(goodNumber)
        return YES;
    else
        return NO;
}


-(void)updateLocationsSetToUI
{
    if(delegate && [delegate respondsToSelector:@selector(didGetDesiredLocations:nearLocation:)])
    {
        //[delegate didGetDesiredLocations:[[AppStorage getInstance] getResellersNearMe:locationDesired]];
        
        [delegate didGetDesiredLocations:[[AppStorage getInstance] getResellersNearMe:locationDesired] nearLocation:locationDesired];
    }
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    NSLog(@"count is %d",[locations count]);
    CLLocation* newLocation = [locations objectAtIndex:[locations count]-1];
    
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 5.0)
    {
   
        return;
    }
    
    if (newLocation.horizontalAccuracy < 0)
    {
        
        return;
    }
    
    NSString *latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    
    NSLog(@"dLatitude : %@", latitude);
    NSLog(@"dLongitude : %@",longitude);
    
    [locationManager stopUpdatingLocation];
    
    locationDesired = [[Location alloc] init];
    
    locationDesired.Latitude = newLocation.coordinate.latitude;
    locationDesired.Longitude = newLocation.coordinate.longitude;
    
    [self doReverseGeoCoding:locationDesired];


}



/*-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    //Checking if the location info is recent and accurate
    //Then form a dict of location and throw it back using the protocol
       
     NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 5.0) return;
    
    if (newLocation.horizontalAccuracy < 0) return;
    
    NSString *latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    
    NSLog(@"dLatitude : %@", latitude);
    NSLog(@"dLongitude : %@",longitude);
    
    [locationManager stopUpdatingLocation];
    
    //NSMutableDictionary* locationDictionary = [[NSMutableDictionary alloc] init];
    
     locationDesired = [[Location alloc] init];
    
    locationDesired.Latitude = newLocation.coordinate.latitude;
    locationDesired.Longitude = newLocation.coordinate.longitude;

//    [locationDictionary setValue:latitude forKey:@"latitude"];
//    [locationDictionary setValue:longitude forKey:@"longitude"];
           // return locationDictionary;
    
    [self doReverseGeoCoding:locationDesired];
    
//    if(self.delegate && [self.delegate respondsToSelector:@selector(didGetDesiredLocations:nearLocation:)])
//    {
//        [delegate didGetDesiredLocations:[[AppStorage getInstance] getResellersNearMe:locationOfUser] nearLocation:locationOfUser];
//    }
//    
////    if(delegate && [delegate respondsToSelector:@selector(didGetLocationOfUser:)])
////    {
////        [delegate didGetLocationOfUser:locationOfUser];
////    }
//    
//    [locationOfUser release];
    
   
    
}*/

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
    
    if(delegate && [delegate respondsToSelector:@selector(didFailToGetDesiredLocations:)])
    {
        [delegate didFailToGetDesiredLocations:[error localizedDescription]];
    }
}


-(void)doReverseGeoCoding:(Location*)location
{
    CLGeocoder* reverseGeoCoder = [[CLGeocoder alloc] init];
    
    CLLocation* locObj = [[CLLocation alloc] initWithLatitude:location.Latitude longitude:location.Longitude];
    
    [reverseGeoCoder reverseGeocodeLocation:locObj completionHandler:^(NSArray *placemarks, NSError *error) {
         NSLog(@"Received placemarks: %@", placemarks);
        CLPlacemark* placemark = [placemarks objectAtIndex:0];
        if (placemark) {
            //Using blocks, get zip code
            //NSString* zipCode = [placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressZIPKey];
            
            location.name = placemark.locality;
            
            NSLog(@"placemarks is %@",placemark.locality);
            
             [self updateLocationsSetToUI];
            
        }
    }];
}

-(void)doForwardGeoCodingOfPlace:(NSString*)place
{
    CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
    locationDesired = [[Location alloc] init];
    
    NSLog(@"place is %@",place);
    
  /*  NSDictionary *locationDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        place, kABPersonAddressStateKey,
                                        @"United States", kABPersonAddressCountryKey,
                                        @"us", kABPersonAddressCountryCodeKey,

                                        nil];

    [geoCoder geocodeAddressDictionary:locationDictionary completionHandler:^(NSArray* placemarks, NSError* error){
        
        NSLog(@"Received placemarks: %@", placemarks);
        NSLog(@"error is %@",[error localizedDescription]);
        
        if(error)
        {
            NSLog(@"error is %@%d",[error localizedDescription],[error code]);
            
            NSString* errorString = @"";
            
            if([error code] == 8)
                errorString = @"Unable to Determine Locations Please check the address entered";
            else if ([error code] == kCLErrorNetwork)
                errorString = @"Please check Netwrork Connection";
            
            if(delegate && [delegate respondsToSelector:@selector(didFailToGetLocationOfUser:)])
            {
                [delegate didFailToGetLocationOfUser:errorString];
            }
        }
        
        else
        {
            for (CLPlacemark* aPlacemark in placemarks)
            {
                // Process the placemark.
                
                // NSLog(@"count is %d",[placemarks count]);
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                CLLocation *location = placemark.location;
                CLLocationCoordinate2D coordinate = location.coordinate;
                NSLog(@"%f%f", coordinate.latitude,coordinate.longitude);
                
                
                
                locationDesired.Latitude = coordinate.latitude;
                locationDesired.Longitude = coordinate.longitude;
                
                [self updateLocationsSetToUI];
                
            }
            
        }

        
    }];*/
    
    
    
    //NSLog(@"place is %@",[place stringByAppendingFormat:@"%@",@",United States"]);
    
    
   // [place stringByAppendingFormat:@"%@",@",United States"]
    
    
    [geoCoder geocodeAddressString:place
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     
                     
                     NSLog(@"Received placemarks: %@", placemarks);
                     
                     if(error)
                     {
                          NSLog(@"error is %@%d",[error localizedDescription],[error code]);
                         
                         NSString* errorString = @"";
                         
                         if([error code] == 8)
                          errorString = @"Unable to Determine Locations Please check the address entered";
                         else if ([error code] == kCLErrorNetwork)
                              errorString = @"Please check Netwrork Connection";
                        
                         
                         if(delegate && [delegate respondsToSelector:@selector(didFailToGetDesiredLocations:)])
                         {
                             [delegate didFailToGetDesiredLocations:errorString];
                         }
                     }
                     
                     else
                     {
                         for (CLPlacemark* aPlacemark in placemarks)
                         {
                             // Process the placemark.
                             
                            // NSLog(@"count is %d",[placemarks count]);
                             
                             CLPlacemark *placemark = [placemarks objectAtIndex:0];
                             CLLocation *location = placemark.location;
                             CLLocationCoordinate2D coordinate = location.coordinate;
                             NSLog(@"%f%f", coordinate.latitude,coordinate.longitude);
                             
                             
                             if((coordinate.latitude < 18.000 || coordinate.latitude > 48.987386) || (coordinate.longitude < -124.626080 || coordinate.longitude > -62.361014) )
                             {
                                 
                                 NSString* errorString = @"Please Select a location in US"; 
                                 if(delegate && [delegate respondsToSelector:@selector(didFailToGetDesiredLocations:)])
                                 {
                                     [delegate didFailToGetDesiredLocations:errorString];
                                 }
                             }
                             
                             else{
                                 
                                 locationDesired.Latitude = coordinate.latitude;
                                 locationDesired.Longitude = coordinate.longitude;
                                 locationDesired.name = placemark.locality;
//                                 NSLog(@"name is %@", locationDesired.name);
//                                 NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//                                 NSLog(@"placemark.country %@",placemark.country);
//                                 NSLog(@"placemark.locality %@",placemark.locality);
//                                 NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
//                                 NSLog(@"placemark.subadmin %@",placemark.subAdministrativeArea);
//                                 NSLog(@"placemark.subLocality %@",placemark.subLocality);
//                                 NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
                                 
                                 [self updateLocationsSetToUI];

                                 
                             }
                             
                                                         
                         }
 
                     }
                     
                    }]; 
    
    
    
}

@end
