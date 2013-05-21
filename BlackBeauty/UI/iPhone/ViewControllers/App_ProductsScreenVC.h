//
//  App_ProductsScreenVC.h
//  BlackBeauty
//
//  Created by Mahi on 5/20/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface App_ProductsScreenVC : UIViewController
{
    UIScrollView* productsScrollView;
}


@property(nonatomic,retain)IBOutlet UIScrollView* productsScrollView;

@end
