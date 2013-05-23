//
//  storeResultsTableCell.m
//  BlackBeauty
//
//  Created by Mahi on 5/22/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import "storeResultsTableCell.h"

@implementation storeResultsTableCell
@synthesize storeName,storeAddress,storeContactNumber,storeDistance;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
