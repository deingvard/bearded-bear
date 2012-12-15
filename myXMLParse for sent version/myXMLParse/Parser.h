//
//  myXMLParse
//
//  Created by Igor on 10.12.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "List.h"

@interface Parser : NSObject <NSXMLParserDelegate> {
    
    AppDelegate *app;
    List *theList;
    NSMutableString *currentElementValue;

}

-(id)initParser;

@end
