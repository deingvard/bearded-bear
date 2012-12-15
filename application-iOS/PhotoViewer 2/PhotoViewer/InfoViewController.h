//
//  InfoViewController.h
//  PhotoViewer
//
//  Created by Igor on 13.12.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface InfoViewController : UIViewController

@property (nonatomic, strong) Photo *currentPhoto;

@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
- (IBAction)dismiss:(id)sender;

@end
