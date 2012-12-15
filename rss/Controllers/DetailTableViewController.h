//
//  Created by Igor on 09.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"
#import "NSString+HTML.h"
#import "SVModalWebViewController.h"
#import <MessageUI/MessageUI.h>
#import <Twitter/Twitter.h>

@interface DetailTableViewController : UITableViewController <UIActionSheetDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate> {
	MWFeedItem *item;
	NSString *dateString, *summaryString;
}

@property (nonatomic, retain) MWFeedItem *item;
@property (nonatomic, retain) NSString *dateString, *summaryString;

- (void)loadWebView:(id)sender;
- (void)shareButtonPressed:(id)sender;

@end
