//
//  DisplayViewController.m
//  PhotoViewer
//
//  Created by Igor on 13.12.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "DisplayViewController.h"

@interface DisplayViewController ()

@end

@implementation DisplayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:[_currentPhoto fileName]];
    [self.currentImage setImage:image];
    [self setTitle:[_currentPhoto name]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    InfoViewController *ivc = [segue destinationViewController];
    [ivc setCurrentPhoto:[self currentPhoto]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
