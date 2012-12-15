//
//  myXMLParse
//
//  Created by Igor on 10.12.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"
@interface DetailViewController : UIViewController{
    
    IBOutlet UITableView *tableView;

}


@property (nonatomic, retain) List *theList;
@end
