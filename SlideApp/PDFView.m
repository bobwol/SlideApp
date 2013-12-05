//
//  PDFView.m
//  SlideApp
//
//  Created by 小林 博久 on 10/11/16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PDFView.h"
#import "PDFDocument.h"


@interface PDFView ()

@property (strong, nonatomic, readwrite) PDFDocument	*pdfDocument;
@property (assign, nonatomic, readwrite) size_t          pageNumber;

@end


@implementation PDFView

@synthesize pageNumber = _pageNumber;


- (id)initWithFrame:(CGRect)frame
        pdfDocument:(PDFDocument *)inPdfDocument
         pageNumber:(size_t)inPageNumber
{
	self = [super initWithFrame:frame];
    if (self != nil) {
		_pdfDocument = [inPdfDocument retain];
		_pageNumber = inPageNumber;
    }

    return self;
}


- (void)dealloc
{
	[_pdfDocument release];

    [super dealloc];
}


- (size_t)pageNumber
{
	return _pageNumber;
}

- (void)setPageNumber:(size_t)inPageNumber
{
	_pageNumber = inPageNumber;

	[self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);

	CGContextTranslateCTM(context, 0.0, rect.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);

	CGPDFPageRef pageRef = [self.pdfDocument pageRef:self.pageNumber];
	if (pageRef != nil) {
		CGRect	pdfRect = CGPDFPageGetBoxRect(pageRef, kCGPDFMediaBox);

		CGAffineTransform transform = CGPDFPageGetDrawingTransform(pageRef, kCGPDFMediaBox, rect, 0, true);
		CGContextConcatCTM(context, transform);

		CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
		CGContextFillRect(context, pdfRect);

		CGContextDrawPDFPage(context, pageRef);
	} else {
		// メモリ不足かな？
	}

	CGContextRestoreGState(context);
}


@end
