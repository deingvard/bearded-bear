//
//  Created by Igor on 09.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feeds : NSObject

@property (nonatomic, retain) NSArray *feedsSave;

- (void)updateSaveWithArray:(NSArray *)array;
- (void)save;

+ (NSMutableArray *)loadFeeds;
+ (NSMutableArray *)loadMenu;

@end
