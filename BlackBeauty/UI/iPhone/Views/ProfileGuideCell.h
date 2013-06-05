//
//  ProfileGuideCell.h
//  BlackBeauty
//
//  Created by Mahi on 6/4/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileGuideCell : UITableViewCell
{
    NSMutableArray* columns;
}

-(void)addColumn:(CGFloat)position;

@end
