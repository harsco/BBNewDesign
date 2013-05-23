//
//  App_ProductsScreenVC.h
//  BlackBeauty
//
//  Created by Mahi on 5/20/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultTableCell.h"
#import "imageFullScreenVC.h"

@interface App_ProductsScreenVC : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView* productsScrollView;
    UITextView* bulletPointsView;
    UITextView* productInfoView;
    
    UIImageView* thumbNailImage;
    UIButton* leftSideButton;
    UIButton* rightSideButton;
    
    UITableView* userOptionsTable;
    
    UIButton* imageZoomButton;
}


@property(nonatomic,retain)IBOutlet UIScrollView* productsScrollView;
@property(nonatomic,retain)IBOutlet UITextView* bulletPointsView;
@property(nonatomic,retain)IBOutlet UITextView* productInfoView;

@property(nonatomic,retain)IBOutlet UIImageView* thumbNailImage;
@property(nonatomic,retain)IBOutlet UIButton* leftSideButton;
@property(nonatomic,retain)IBOutlet UIButton* rightSideButton;
@property(nonatomic,retain)IBOutlet UITableView* userOptionsTable;
@property(nonatomic,retain)IBOutlet UIButton* imageZoomButton;


-(IBAction)onImageZoomButtonClicked:(id)sender;

@end
