//
//  Created by Igor on 09.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FeedViewController.h"
#import "Feeds.h"

#import "AboutViewController.h"

@class FeedViewController;
@class AboutViewController;

@interface MasterViewController : UITableViewController <UIAlertViewDelegate> {
    UIBarButtonItem *editButton;
    UIBarButtonItem *addButton;
    
    UIAlertView *addFeedPrompt;
    
    NSMutableArray *feeds;
    NSArray *menu;
    
}

@property (strong, nonatomic) FeedViewController *feedViewController;
@property (nonatomic, retain) NSMutableArray *feeds;
@property (nonatomic, retain) NSArray *menu;

@property (strong, nonatomic) AboutViewController *aboutViewController;

- (void)userDidSelectEdit:(id)sender;
- (void)userDidSelectAdd:(id)sender;

- (void)addFeed:(NSString *)feedURL;

@end
