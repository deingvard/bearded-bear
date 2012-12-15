//
//  Created by Igor on 09.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "MasterViewController.h"

@implementation MasterViewController

@synthesize feedViewController = _feedViewController, aboutViewController = _aboutViewController;
@synthesize feeds, menu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Home", @"Home Global");
        self.feeds = [NSMutableArray array];
    }
    return self;
}
							
- (void)dealloc
{
    [_feedViewController release];
    [_aboutViewController release];
    [feeds dealloc];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)addFeed:(NSString *)feedURL
{
    NSLog(@"addFeed:%@", feedURL);
    [self.feeds insertObject:feedURL atIndex:0];
    [self.tableView beginUpdates];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[self.feeds indexOfObject:feedURL] inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath]withRowAnimation:UITableViewRowAnimationTop];
    
    [self.tableView endUpdates];
    
    Feeds *f = [[Feeds alloc] init];
    [f updateSaveWithArray:self.feeds];
    [f release];
}

- (void)userDidSelectEdit:(id)sender
{
    NSLog(@"userDidSelectEdit:");
    if (self.tableView.editing == NO) {
        [self.tableView setEditing:YES];
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleDone;
        self.navigationItem.leftBarButtonItem.title = NSLocalizedString(@"Done", @"Done Global");
    }
    else if (self.tableView.editing == YES) {
        [self.tableView setEditing:NO];
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleBordered;
        self.navigationItem.leftBarButtonItem.title = NSLocalizedString(@"Edit", @"Edit Global");
    }
}

- (void)userDidSelectAdd:(id)sender
{
    NSLog(@"userDidSelectAdd:");    
    addFeedPrompt = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Add Feed", @"Alert Title Global") 
                                               message:NSLocalizedString(@"Enter the URL of the RSS feed", @"Alert Message Global") 
                                              delegate:self 
                                     cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel Global")
                                     otherButtonTitles:NSLocalizedString(@"Add", @"Add Global"), nil];
    [addFeedPrompt setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [addFeedPrompt textFieldAtIndex:0].keyboardType = UIKeyboardTypeURL;
    [addFeedPrompt textFieldAtIndex:0].text = @"http://";
    [addFeedPrompt show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    if (buttonIndex == 1) {
        NSString *rawFeedURLString = [alertView textFieldAtIndex:0].text;
        
        if ([rawFeedURLString rangeOfString:@"http://"].location == NSNotFound) {
            // prepend http://
            NSString *fixedFeedURLString = [NSString stringWithFormat:@"http://%@", rawFeedURLString];
            [self addFeed:fixedFeedURLString];
        } 
        else {
            [self addFeed:rawFeedURLString];
        }
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
    
    editButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit", @"Edit Global") 
                                                  style:UIBarButtonItemStyleBordered 
                                                 target:self 
                                                 action:@selector(userDidSelectEdit:)];
    
    addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                              target:self 
                                                              action:@selector(userDidSelectAdd:)];
    
    self.navigationItem.leftBarButtonItem = editButton;
    self.navigationItem.rightBarButtonItem = addButton;
    
    if ([self.feeds count] == 1) 
        [self.navigationItem.leftBarButtonItem setEnabled:NO];
    else
        [self.navigationItem.leftBarButtonItem setEnabled:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"feeds.plist"];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (fileExists) {
        NSLog(@"Loading save file");
        self.feeds = [Feeds loadFeeds];
        NSLog(@"Loaded: %@", self.feeds);
    }
    else {
        NSLog(@"No save data, reinitializing array");
        self.feeds = [NSMutableArray array];
    }
    
    NSArray *kPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *kDocumentsDirectory = kPaths[0];
    NSString *kFilePath = [kDocumentsDirectory stringByAppendingPathComponent:@"menu.plist"];
    
    BOOL kFileExists = [[NSFileManager defaultManager] fileExistsAtPath:kFilePath];
    if (kFileExists) {
        self.menu = [Feeds loadMenu];
        NSLog(@"Loaded Menu: %@", self.menu);
    } 
    else {
        self.menu = @[NSLocalizedString(@"About", @"About Global")];
        [self.menu writeToFile:kFilePath atomically:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
		case 0: return [feeds count];
		default: return 1;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (indexPath.section) {
        case 1:
            cell.textLabel.text = (self.menu)[0];
            break;
            
        default:
            // Configure the cell.
            cell.textLabel.text = (self.feeds)[indexPath.row];
            break;
    }
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source.
        [self.feeds removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        Feeds *f = [[Feeds alloc] init];
        [f updateSaveWithArray:self.feeds];
        [f release];
    } 
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
        return UITableViewCellEditingStyleNone;
    else
        return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (!self.aboutViewController) {
            self.aboutViewController = [[AboutViewController alloc] initWithStyle:UITableViewStyleGrouped];
        }
        [self.navigationController pushViewController:self.aboutViewController animated:YES];
    }
    else {
        self.feedViewController = [[[FeedViewController alloc] initWithStyle:UITableViewStyleGrouped andIndexofFeed:indexPath.row] autorelease];
        [self.navigationController pushViewController:self.feedViewController animated:YES];
    }
}

@end
