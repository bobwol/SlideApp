//
//  CoverViewController.m
//  SlideApp
//
//  Created by 小林 博久 on 2013/12/05.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "CoverViewController.h"


@interface CoverViewController ()

@property (strong, nonatomic) AVPlayerItem		*playerItem;
@property (strong, nonatomic) AVPlayer			*player;

- (void)setupPlayer;

- (void)onTap:(id)sender;

- (void)onPlayerDidPlayToEndTime:(NSNotification *)notification;

@end


@implementation CoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }

    return self;
}

- (void)dealloc
{
	[_playerView release];

	[_playerItem release];
	[_player release];

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

	[self setupPlayer];
	[self.player play];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

	[self.player pause];
	[[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];

	[self.playerView removeFromSuperview];
}


- (void)setupPlayer
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"cover"
													 ofType:@"mp4"];
	NSURL *url = [NSURL fileURLWithPath:path];
	self.playerItem = [[[AVPlayerItem alloc] initWithURL:url] autorelease];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(onPlayerDidPlayToEndTime:)
												 name:AVPlayerItemDidPlayToEndTimeNotification
											   object:self.playerItem];

	self.player = [[[AVPlayer alloc] initWithPlayerItem:self.playerItem] autorelease];
	AVPlayerLayer* layer = (AVPlayerLayer *)self.playerView.layer;
	layer.videoGravity = AVLayerVideoGravityResizeAspect;
	layer.player = self.player;
}


- (void)onTap:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}


- (void)onPlayerDidPlayToEndTime:(NSNotification *)notification
{
	[self.player seekToTime:kCMTimeZero];
	[self.player play];
}

@end
