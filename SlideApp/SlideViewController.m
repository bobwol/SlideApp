//
//  SlideViewController.m
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import "SlideViewController.h"
#import "AppDelegate.h"
#import "PDFView.h"
#import "UIImage+animatedGIF.h"


@interface SlideViewController ()

@property (assign, nonatomic, readwrite) BOOL isExternal;
@property (strong, nonatomic) PDFDocument *pdfDocument;
@property (assign, nonatomic, readwrite) int page;

@end

@implementation SlideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             external:(BOOL)isExternal
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        _isExternal = isExternal;
    }

    return self;
}

- (void)dealloc
{
    [_pdfDocument release];

    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

	NSLog(@"page:%d", self.page);

    CGRect frame;
    frame = self.view.window.frame;
    if (!self.isExternal) {
        frame = CGRectMake(0.0, 0.0, 1024.0, 768.0);
    } else {
        frame = [AppDelegate getAppDelegate].extFrame;
    }

    PDFView *pdfView = [[[PDFView alloc] initWithFrame:frame
                                           pdfDocument:self.pdfDocument
                                            pageNumber:self.page] autorelease];
    [self.view addSubview:pdfView];

    if (self.page == 1) {
        NSString *path = nil;
        if (!self.isExternal) {
            path = [[NSBundle mainBundle] pathForResource:@"top"
                                                   ofType:@"gif"];
        } else {
            path = [[NSBundle mainBundle] pathForResource:@"exttop"
                                                   ofType:@"gif"];
        }

        NSURL *url = [NSURL fileURLWithPath:path];
        UIImage* image = [UIImage animatedImageWithAnimatedGIFURL:url];

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView setImage:image];
        [self.view addSubview:imageView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setContent:(PDFDocument *)content
			atPage:(int)page
{
    self.pdfDocument = content;
	self.page = page;
}

@end
