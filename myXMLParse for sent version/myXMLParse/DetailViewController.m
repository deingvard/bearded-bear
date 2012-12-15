//
//  myXMLParse
//
//  Created by Igor on 10.12.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@implementation DetailViewController
@synthesize theList;

AppDelegate *app;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = theList.name;

    app = [[UIApplication sharedApplication] delegate];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [app.listArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	switch(indexPath.section)
	{
		case 0:
			cell.textLabel.text = theList.price;
			break;
		case 1:
			cell.textLabel.text = theList.description;
			break;

	}
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionName = nil;
	
	switch(section)
	{
		case 0:
			sectionName = @"Price";
			break;
		case 1:
			sectionName = @"Description";
			break;
	}
	return sectionName;
}							
@end
