//
//  ProfileGuideVC.h
//  BlackBeauty
//
//  Created by Mahi on 6/4/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileGuideCell.h"

@interface ProfileGuideVC : UIViewController
{
    UITableView* profileGuideView;
}

@property(nonatomic,retain)IBOutlet UITableView* profileGuideView;

@end
