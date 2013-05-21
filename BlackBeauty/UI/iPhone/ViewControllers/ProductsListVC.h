//
//  ProductsListVC.h
//  BlackBeauty
//
//  Created by Mahi on 5/16/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App_ProductsScreenVC.h"

@interface ProductsListVC : UIViewController
{
     IBOutlet UINavigationBar* headerView;
}


@property(nonatomic,retain)IBOutlet UINavigationBar* headerView;

-(IBAction)onBBGlassClicked:(id)sender;

@end
