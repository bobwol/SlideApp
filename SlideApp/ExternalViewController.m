//
//  ExternalViewController.m
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import "ExternalViewController.h"
#import "SlideViewController.h"
#import "SlideAppConfig.h"
#import "PDFDocument.h"


@interface ExternalViewController ()

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) PDFDocument *pdfDocument;
@property (assign, nonatomic) int pageMax;
@property (assign, nonatomic) int currentPage;

- (void)toTopPage;

@end


@implementation ExternalViewController

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
    [_pageViewController release];
    [_pdfDocument release];

	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // load PDF
	NSString *path = [[NSBundle mainBundle] pathForResource:EXT_SLIDE_FILENAME
													 ofType:EXT_SLIDE_FILETYPE];
	NSURL *url = [NSURL fileURLWithPath:path];
    self.pdfDocument = [[[PDFDocument alloc] initWithUrl:url] autorelease];

	self.pageMax = (int)self.pdfDocument.numberOfPages;
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (SlideViewController *)slideViewControllerAtPage:(int)page
{
	SlideViewController *vc = [[[SlideViewController alloc] initWithNibName:@"SlideViewController"
                                                                     bundle:nil
                                                                   external:YES] autorelease];

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
}

- (IBAction)onTopButton:(id)sender
{
    [self toTopPage];
}


- (void)toTopPage
{
    NSArray *vcs = [self.pageViewController viewControllers];
    SlideViewController *svc = [vcs objectAtIndex:0];
    if (svc != nil && svc.page > 1) {
        vcs = [NSArray arrayWithObject:[self slideViewControllerAtPage:1]];
        [self.pageViewController setViewControllers:vcs
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:YES
                                         completion:nil];
    }
}

- (void)toPage:(int)page
{
    NSLog(@"toPage: %d", page);

    NSArray *vcs = [self.pageViewController viewControllers];
    SlideViewController *svc = [vcs objectAtIndex:0];
    if (svc != nil) {
        if (page < svc.page) {
            vcs = [NSArray arrayWithObject:[self slideViewControllerAtPage:page]];
            [self.pageViewController setViewControllers:vcs
                                              direction:UIPageViewControllerNavigationDirectionReverse
                                               animated:YES
                                             completion:nil];
        } else if (page > svc.page) {
            vcs = [NSArray arrayWithObject:[self slideViewControllerAtPage:page]];
            [self.pageViewController setViewControllers:vcs
                                              direction:UIPageViewControllerNavigationDirectionForward
                                               animated:YES
                                             completion:nil];
        } else {
        }
    }
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
	  viewControllerBeforeViewController:(UIViewController *)viewController
{
	UIViewController *vc = nil;

	int page = ((SlideViewController*)viewController).page;
	if (page > 1) {
		vc = [self slideViewControllerAtPage:page - 1];
	}

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

	return vc;
}

- (void)pageViewController:(UIPageViewController *)pageViewController
 willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    NSLog(@"-----willTransitionToViewControllers");
}

- (void)pageViewController:(UIPageViewController *)pageViewController
		didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
	   transitionCompleted:(BOOL)completed
{
    NSLog(@"-----didFinishAnimating: finished=%d, completed=%d", finished, completed);
}

@end
