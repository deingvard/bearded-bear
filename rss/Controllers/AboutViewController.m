//
//  Created by Igor on 09.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"About", @"About Global");
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background-Landscape~ipad.png"]];
        }
        else {
            self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background-Portrait~ipad.png"]];
        }
    }
    else {
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background-Landscape~iphone.png"]];
        }
        else {
            self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background-Portrait~iphone.png"]];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"Version Information", @"About Table Header Global");
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return NSLocalizedString(@"Copyright 2012 Igor Ivliev", @"Copyright Global");
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Version", @"Version Global"), [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]];
    }
    else if (indexPath.row ==1) {
        cell.textLabel.text = NSLocalizedString(@"Check For Updates", @"Check For Updates Global");
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
