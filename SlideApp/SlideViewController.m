//
//  SlideViewController.m
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import "SlideViewController.h"
#import "PDFView.h"


@interface SlideViewController ()

@property (strong, nonatomic) PDFDocument *pdfDocument;
@property (assign, nonatomic, readwrite) int page;

@end

@implementation SlideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }

    return self;
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
