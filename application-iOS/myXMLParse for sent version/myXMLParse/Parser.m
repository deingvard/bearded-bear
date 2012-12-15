//
//  myXMLParse
//
//  Created by Igor on 10.12.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "Parser.h"

@implementation Parser

-(id) initParser {
    
    if (self == [super init]) {
        
        app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
    }
    return self;
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"ordersList"]) {
        
        app.listArray = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"order" ] ){
        
        theList = [[List alloc] init];
        
        theList.myID = [attributeDict[@"id"] integerValue];
    
    }else if([elementName isEqualToString:@"item" ] ){
        
        theList = [[List alloc] init];
        
        theList.myID = [attributeDict[@"price"] integerValue];
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    else
        [currentElementValue appendString:string];
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"ordersList"]) {
        return;
    }
    
    
    if ([elementName isEqualToString:@"order"]) {
        [app.listArray addObject:theList];
        
        theList = nil;
        
    }if ([elementName isEqualToString:@"item"]) {
        [app.listArray addObject:theList];
        
        theList = nil;
    }
    else 
        [theList setValue:currentElementValue forKey:elementName];
    
    currentElementValue = nil;

}


@end
