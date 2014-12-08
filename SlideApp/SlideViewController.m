//
//  SlideViewController.m
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import "SlideViewController.h"
#import "PDFView.h"
#import "UIImage+animatedGIF.h"


@interface SlideViewController ()

@property (strong, nonatomic) PDFDocument *pdfDocument;
@property (assign, nonatomic, readwrite) int page;

@end

@implementation SlideViewController

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
    [_pdfDocument release];

    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

	NSLog(@"page:%d", self.page);

    CGRect frame = self.view.frame;
    PDFView *pdfView = [[[PDFView alloc] initWithFrame:frame
                                           pdfDocument:self.pdfDocument
                                            pageNumber:self.page] autorelease];
    [self.view addSubview:pdfView];

    if (self.page == 1) {

        NSString *path = [[NSBundle mainBundle] pathForResource:@"top"
                                                         ofType:@"gif"];
        NSURL *url = [NSURL fileURLWithPath:path];
        UIImage* image = [UIImage animatedImageWithAnimatedGIFURL:url];

        CGRect frame = CGRectMake(0.0, 0.0, 1024.0, 768.0);
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
