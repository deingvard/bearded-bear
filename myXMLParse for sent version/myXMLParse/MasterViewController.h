//
//  myXMLParse
//
//  Created by Igor on 10.12.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "List.h"
@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, retain) AppDelegate *app;
@property (nonatomic, retain) List *theList;

@end
