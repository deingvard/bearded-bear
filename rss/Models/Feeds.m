//
//  Created by Igor on 09.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "Feeds.h"

@implementation Feeds
@synthesize feedsSave;

- (void)updateSaveWithArray:(NSArray *)array
{
    self.feedsSave = array;
    NSLog(@"SAVING: %@", self.feedsSave);
    [self save];
}

- (void)save 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"feeds.plist"];
    [self.feedsSave writeToFile:filePath atomically:YES];
    NSLog(@"TO: %@", filePath);
}

+ (NSMutableArray *)loadFeeds
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"feeds.plist"];
    NSMutableArray *arrayFromPlist = [NSArray arrayWithContentsOfFile:filePath];
    return arrayFromPlist;
}

+ (NSMutableArray *)loadMenu
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"menu.plist"];
    NSMutableArray *arrayFromPlist = [NSArray arrayWithContentsOfFile:filePath];
    return arrayFromPlist;
}

- (void)dealloc
{
    [feedsSave release];
    [super dealloc];
}

@end
