//
//  aboutUSVC.h
//  BlackBeauty
//
//  Created by Mahi on 4/15/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "aboutHarscoVC.h"

@interface aboutUSVC : UIViewController
{
    UINavigationBar* aboutUsHeader;
    UIImageView* aboutUS;
}

@property(nonatomic,retain)IBOutlet UINavigationBar* aboutUsHeader;
@property(nonatomic,retain)IBOutlet UIImageView* aboutUS;

@end
