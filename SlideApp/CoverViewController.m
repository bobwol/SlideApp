//
//  CoverViewController.m
//  SlideApp
//
//  Created by 小林 博久 on 2013/12/05.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import "CoverViewController.h"
#import "UIImage+GIF.h"


@interface CoverViewController ()

- (void)onTap:(id)sender;

@end


@implementation CoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
    }

    return self;
}

- (void)dealloc
{
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // touch event handler
    CGRect frame = self.view.frame;
    UIView *view = [[[UIView alloc] initWithFrame:frame] autorelease];

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [view addGestureRecognizer:tapGesture];

    [self.view addSubview:view];
    
    UIImage* image = [UIImage animatedGIFNamed:@"top"];
    [self.animationView setImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)onTap:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
