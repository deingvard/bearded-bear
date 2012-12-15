//
//  Created by Igor on 09.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "DetailTableViewController.h"

typedef enum { SectionHeader, SectionDetail } Sections;
typedef enum { SectionHeaderTitle, SectionHeaderDate, SectionHeaderURL } HeaderRows;
typedef enum { SectionDetailSummary } DetailRows;

@implementation DetailTableViewController

@synthesize item, dateString, summaryString;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
		
    }
    return self;
}

- (void)loadWebView:(id)sender
{
    UIActionSheet *readMore = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Read More", @"Read More Global") 
                                                          delegate:self
                                                 cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel Global") 
                                            destructiveButtonTitle:nil 
                                                 otherButtonTitles:NSLocalizedString(@"Open in Web View", @"Open WV Global"), NSLocalizedString(@"Open in Safari", @"Open Safari Global"), nil];
    [readMore showFromToolbar:self.navigationController.toolbar];
    [readMore release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:item.link];
        [self presentModalViewController:webViewController animated:YES];	
        [webViewController release];
    }
    if (buttonIndex == 1) {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.link]];
    }
}

- (void)shareButtonPressed:(id)sender
{
    UIAlertView *shareView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Share This Article", @"Share Title") 
                                                        message:NSLocalizedString(@"Sharing Options", @"Share Message") 
                                                       delegate:self 
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel Global") 
                                              otherButtonTitles:NSLocalizedString(@"Email", @"Email Global"), NSLocalizedString(@"Tweet", @"Tweet Global"), nil];
    [shareView show];
    [shareView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:item.link];
        NSString *message = @"Check out this article I read.\n\n %@";
        
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:[NSString stringWithFormat:NSLocalizedString(@"Check out this article!", @"Mail Subject Global"), item.title]];
        [controller setMessageBody:[NSString stringWithFormat:NSLocalizedString(message, @"Mail Message Global"), url] isHTML:NO]; 
        [self presentModalViewController:controller animated:YES];
        [controller release];
    }
    if (buttonIndex == 2) {
        TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
        if ([item.title length] >= 50) {
            NSString *title = [item.title substringToIndex:50];
            NSString *htmlFixedTitle = [title stringByDecodingHTMLEntities];
            NSArray *splitTitle = [htmlFixedTitle componentsSeparatedByString:@" "];
            NSMutableArray *kSplitTitle = [NSMutableArray arrayWithArray:splitTitle];
            [kSplitTitle removeObjectAtIndex:[kSplitTitle count]-1];
            NSString *truncatedTitle = [kSplitTitle componentsJoinedByString:@" "];
            NSString *trimmedTitle = [truncatedTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *fixedTitle = [NSString stringWithFormat:@"%@...", trimmedTitle];
            
            [twitter setInitialText:[NSString stringWithFormat:NSLocalizedString(@"Check out this article!", @"Mail Subject Global"), fixedTitle]];
            [twitter addURL:[NSURL URLWithString:item.link]];
            [self presentViewController:twitter animated:YES completion:nil];
            
            twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
                [self dismissModalViewControllerAnimated:YES];
            };

        }
        else if ([item.title length] >= 40 && [item.title length] < 50) {
            NSString *title = [item.title substringToIndex:40];
            NSString *htmlFixedTitle = [title stringByDecodingHTMLEntities];
            NSArray *splitTitle = [htmlFixedTitle componentsSeparatedByString:@" "];
            NSMutableArray *kSplitTitle = [NSMutableArray arrayWithArray:splitTitle];
            [kSplitTitle removeObjectAtIndex:[kSplitTitle count]-1];
            NSString *truncatedTitle = [kSplitTitle componentsJoinedByString:@" "];
            NSString *trimmedTitle = [truncatedTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *fixedTitle = [NSString stringWithFormat:@"%@...", trimmedTitle];
            
            [twitter setInitialText:[NSString stringWithFormat:NSLocalizedString(@"Check out this article!", @"Mail Subject Global"), fixedTitle]];
            [twitter addURL:[NSURL URLWithString:item.link]];
            [self presentViewController:twitter animated:YES completion:nil];
            
            twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
                [self dismissModalViewControllerAnimated:YES];
            };
            
        }
        else if ([item.title length] >= 30 && [item.title length] < 40) {
            NSString *title = [item.title substringToIndex:30];
            NSString *htmlFixedTitle = [title stringByDecodingHTMLEntities];
            NSArray *splitTitle = [htmlFixedTitle componentsSeparatedByString:@" "];
            NSMutableArray *kSplitTitle = [NSMutableArray arrayWithArray:splitTitle];
            [kSplitTitle removeObjectAtIndex:[kSplitTitle count]-1];
            NSString *truncatedTitle = [kSplitTitle componentsJoinedByString:@" "];
            NSString *trimmedTitle = [truncatedTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *fixedTitle = [NSString stringWithFormat:@"%@...", trimmedTitle];
            
            [twitter setInitialText:[NSString stringWithFormat:NSLocalizedString(@"Check out this article!", @"Mail Subject Global"), fixedTitle]];
            [twitter addURL:[NSURL URLWithString:item.link]];
            [self presentViewController:twitter animated:YES completion:nil];
            
            twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
                [self dismissModalViewControllerAnimated:YES];
            };
            
        }
        else {
            [twitter setInitialText:[NSString stringWithFormat:NSLocalizedString(@"Check out this article!", @"Mail Subject Global"), item.title]];
            [twitter addURL:[NSURL URLWithString:item.link]];
            [self presentViewController:twitter animated:YES completion:nil];
            
            twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
                [self dismissModalViewControllerAnimated:YES];
            };

        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
        UIAlertView *mailSent = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Email Sent", @"Mail Success Title") 
                                                           message:NSLocalizedString(@"Email sent successfully!", @"Mail Success Message") 
                                                          delegate:self 
                                                 cancelButtonTitle:NSLocalizedString(@"Dismiss", @"Dismiss Global") 
                                                 otherButtonTitles:nil];
        [mailSent show];
        [mailSent release];
    }
    else {
        NSLog(@"Failure");
        UIAlertView *mailNotSent = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Email Not Sent", @"Mail Error Title") 
                                                           message:[NSString stringWithFormat:NSLocalizedString(@"Email was not sent. An error has occured: '%@'", @"Mail Error Message"), error] 
                                                          delegate:self 
                                                 cancelButtonTitle:NSLocalizedString(@"Dismiss", @"Dismiss Global") 
                                                 otherButtonTitles:nil];
        [mailNotSent show];
        [mailNotSent release];
    }
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	// Super
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
    
	// Date
	if (item.date) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterMediumStyle];
		[formatter setTimeStyle:NSDateFormatterMediumStyle];
		self.dateString = [NSString stringWithFormat:@"Posted: %@", [formatter stringFromDate:item.date]];
		[formatter release];
	}
	
	// Summary
	if (item.summary) {
		self.summaryString = [item.summary stringByConvertingHTMLToPlainText];
	} else {
		self.summaryString = @"[No Summary]";
	}
	
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *action = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(loadWebView:)];
    [self setToolbarItems:@[space, action] animated:YES];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Share", @"Share Global") 
                                                                    style:UIBarButtonItemStyleBordered 
                                                                   target:self 
                                                                   action:@selector(shareButtonPressed:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.toolbarHidden = NO;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	switch (section) {
		case 0: return 2;
		default: return 1;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        return NSLocalizedString(@"Read Excerpt", @"Read Header Global");
    else
        return nil;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get cell
	static NSString *CellIdentifier = @"CellA";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	// Display
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.font = [UIFont systemFontOfSize:15];
	if (item) {
		
		// Item Info
		NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
		
		// Display
		switch (indexPath.section) {
			case SectionHeader: {
				
				// Header
				switch (indexPath.row) {
					case SectionHeaderTitle:
						cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
                        cell.textLabel.numberOfLines = 0;
						cell.textLabel.text = itemTitle;
						break;
					case SectionHeaderDate:
						cell.textLabel.text = dateString ? dateString : @"[No Date]";
						break;
				}
				break;
				
			}
			case SectionDetail: {
				
				// Summary
				cell.textLabel.text = summaryString;
				cell.textLabel.numberOfLines = 0; // Multiline
				break;
				
			}
		}
	}
    
    return cell;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == SectionHeader) {
		
		// Regular
		return 34;
		
	} else {
		
		// Get height of summary
		NSString *summary = @"[No Summary]";
		if (summaryString) summary = summaryString;
		CGSize s = [summary sizeWithFont:[UIFont systemFontOfSize:15] 
					   constrainedToSize:CGSizeMake(self.view.bounds.size.width - 40, MAXFLOAT)  // - 40 For cell padding
						   lineBreakMode:UILineBreakModeWordWrap];
		return s.height + 16; // Add padding
		
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Open URL
	if (indexPath.section == SectionHeader && indexPath.row == SectionHeaderURL) {
		if (item.link) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.link]];
		}
	}
	
	// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[dateString release];
	[summaryString release];
	[item release];
    [super dealloc];
}


@end