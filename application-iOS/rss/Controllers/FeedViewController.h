//
//  Created by Igor on 09.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Feeds.h"
#import "MWFeedParser.h"
#import "NSString+HTML.h"
#import "SVProgressHUD.h"
#import "DetailTableViewController.h"
#import "PullToRefreshView.h"

@interface FeedViewController : UITableViewController <MWFeedParserDelegate, PullToRefreshViewDelegate> {
    MWFeedParser *feedParser;
	NSMutableArray *parsedItems;
	
	NSArray *itemsToDisplay;
	NSDateFormatter *formatter;
    
    PullToRefreshView *pull;
}


- (id)initWithStyle:(UITableViewStyle)style andIndexofFeed:(int)index;

@property (nonatomic, retain) NSString *activeIndex;

@property (nonatomic, retain) NSArray *itemsToDisplay;

@property (nonatomic, retain) PullToRefreshView *pull;

@end
