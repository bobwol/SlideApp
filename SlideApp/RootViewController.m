//
//  RootViewController.m
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import "RootViewController.h"
#import "SlideViewController.h"
#import "PDFDocument.h"


@interface RootViewController ()

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) PDFDocument *pdfDocument;
@property (assign, nonatomic) int pageMax;
@property (assign, nonatomic) int currentPage;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }

    return self;
}

- (void)dealloc
{
	[_pageViewController release];

	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Load PDF
	NSString *path = [[NSBundle mainBundle] pathForResource:@"slide"
													 ofType:@"pdf"];
	NSURL *url = [NSURL fileURLWithPath:path];
    self.pdfDocument = [[PDFDocument alloc] initWithUrl:url];

	self.pageMax = self.pdfDocument.numberOfPages;
	self.currentPage = 1;

	self.pageViewController = [[[UIPageViewController alloc]
								initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
								navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
								options:nil] autorelease];

	self.pageViewController.delegate = self;
	self.pageViewController.dataSource = self;
	self.pageViewController.view.frame = self.view.frame;

	UIViewController* vc = [self slideViewControllerAtPage:1];

	NSArray *viewControllers = [NSArray arrayWithObject:vc];
	[self.pageViewController setViewControllers:viewControllers
									  direction:UIPageViewControllerNavigationDirectionForward
									   animated:NO
									 completion:nil];

	[self addChildViewController:self.pageViewController];
	[self.view addSubview:self.pageViewController.view];
	[self.pageViewController didMoveToParentViewController:self];

	[self.view bringSubviewToFront:self.controlPanel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
		didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
	   transitionCompleted:(BOOL)completed
{
	if (completed) {
	}
}

@end
