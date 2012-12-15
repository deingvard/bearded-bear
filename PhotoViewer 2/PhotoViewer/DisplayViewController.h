//
//  DisplayViewController.h
//  PhotoViewer
//
//  Created by Igor on 13.12.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "InfoViewController.h"

@interface DisplayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *currentImage;

@property (nonatomic, strong) Photo *currentPhoto;

@end
