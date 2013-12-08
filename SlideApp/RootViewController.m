//
//  RootViewController.m
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import "RootViewController.h"
#import "CoverViewController.h"
#import "SlideViewController.h"
#import "SlideAppConfig.h"
#import "PDFDocument.h"


static BOOL sFirstTime = YES;


@interface RootViewController ()

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) PDFDocument *pdfDocument;
@property (assign, nonatomic) int pageMax;
@property (assign, nonatomic) int currentPage;

@property (strong, nonatomic) NSTimer *countDownTimer;
@property (assign, nonatomic) int countDownToCover;

- (void)onCountDownTimer:(NSTimer *)timer;

- (void)presentCoverViewController:(BOOL)animated;

@end


@implementation RootViewController

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
    [_controlPanel release];
	[_pageViewController release];
    [_pdfDocument release];
    [_countDownTimer release];

	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // load PDF
	NSString *path = [[NSBundle mainBundle] pathForResource:SLIDE_FILENAME
													 ofType:SLIDE_FILETYPE];
	NSURL *url = [NSURL fileURLWithPath:path];
    self.pdfDocument = [[[PDFDocument alloc] initWithUrl:url] autorelease];

	self.pageMax = self.pdfDocument.numberOfPages;
	self.currentPage = 1;

    // setup UIPageViewController
	self.pageViewController = [[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                             options:nil] autorelease];

	self.pageViewController.delegate = self;
	self.pageViewController.dataSource = self;
	self.pageViewController.view.frame = self.view.frame;

	[self addChildViewController:self.pageViewController];
	[self.view addSubview:self.pageViewController.view];
	[self.pageViewController didMoveToParentViewController:self];

    // bring control panel to front
	[self.view bringSubviewToFront:self.controlPanel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

	UIViewController* vc = [self slideViewControllerAtPage:1];
	NSArray *vcs = [NSArray arrayWithObject:vc];
    [self.pageViewController setViewControllers:vcs
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];

    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:self
                                                         selector:@selector(onCountDownTimer:)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (sFirstTime) {
        [self presentCoverViewController:NO];
        
        sFirstTime = NO;
    }

    self.countDownToCover = COUNTDOWN_SECONDS;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}


- (SlideViewController *)slideViewControllerAtPage:(int)page
{
	SlideViewController *vc = [[[SlideViewController alloc] initWithNibName:@"SlideViewController"
                                                                     bundle:nil] autorelease];
	[vc setContent:self.pdfDocument
            atPage:page];

	return vc;
}


- (IBAction)onLeftButton:(id)sender
{
    NSArray *vcs = [self.pageViewController viewControllers];
    SlideViewController *svc = [vcs objectAtIndex:0];
    if (svc == nil || svc.page <= 1) {
        return;
    }

    vcs = [NSArray arrayWithObject:[self slideViewControllerAtPage:svc.page - 1]];
    [self.pageViewController setViewControllers:vcs
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:nil];

    self.countDownToCover = COUNTDOWN_SECONDS;
}

- (IBAction)onRightButton:(id)sender
{
    NSArray *vcs = [self.pageViewController viewControllers];
    SlideViewController *svc = [vcs objectAtIndex:0];
    if (svc == nil || svc.page >= self.pageMax) {
        return;
    }

    vcs = [NSArray arrayWithObject:[self slideViewControllerAtPage:svc.page + 1]];
    [self.pageViewController setViewControllers:vcs
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];

    self.countDownToCover = COUNTDOWN_SECONDS;
}

- (IBAction)onTopButton:(id)sender
{
    [self presentCoverViewController:YES];
}


- (void)onCountDownTimer:(NSTimer *)timer
{
    if (self.countDownToCover-- <= 0) {
        [self presentCoverViewController:YES];
    }
}


- (void)presentCoverViewController:(BOOL)animated
{
    UIViewController *vc = [[[CoverViewController alloc] initWithNibName:@"CoverViewController"
                                                                  bundle:nil] autorelease];
    [self presentViewController:vc
                       animated:animated
                     completion:nil];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
	  viewControllerBeforeViewController:(UIViewController *)viewController
{
	UIViewController *vc = nil;

	int page = ((SlideViewController*)viewController).page;
	if (page > 1) {
		vc = [self slideViewControllerAtPage:page - 1];
	}

    self.countDownToCover = COUNTDOWN_SECONDS;

	return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
	   viewControllerAfterViewController:(UIViewController *)viewController
{
	UIViewController *vc = nil;

	int page = ((SlideViewController*)viewController).page;
	if (page < self.pageMax) {
		vc = [self slideViewControllerAtPage:page + 1];
	}

    self.countDownToCover = COUNTDOWN_SECONDS;

	return vc;
}

- (void)pageViewController:(UIPageViewController *)pageViewController
		didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
	   transitionCompleted:(BOOL)completed
{
	if (completed) {
	}
}

@end
