//
//  faqDetailsVC.h
//  BlackBeauty
//
//  Created by Mahi on 5/30/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQ.h"
#import <MessageUI/MessageUI.h>

@interface faqDetailsVC : UIViewController<UIWebViewDelegate,MFMailComposeViewControllerDelegate>
{
    UIWebView* faqAnswerView;
    UILabel* faqQuestion;
    UIButton* callUSButton;
    UIButton* emailUSButton;
    UIImageView* callImage;
    UIImageView* emailImage;
    FAQ* faqToBeShown;
    NSURL* savedLink;
}

@property(nonatomic,retain)IBOutlet UIWebView* faqAnswerView;
@property(nonatomic,retain)IBOutlet UILabel* faqQuestion;
@property(nonatomic,retain)IBOutlet UIButton* callUSButton;
@property(nonatomic,retain)IBOutlet UIButton* emailUSButton;
@property(nonatomic,retain)IBOutlet UIImageView* callImage;
@property(nonatomic,retain)IBOutlet UIImageView* emailImage;


-(IBAction)onCallUsClicked:(id)sender;
-(IBAction)onEmailUsClicked:(id)sender;
-(id)initWithFAQ:(FAQ*)faqObject;

@end
