//
//  PDFDocument.m
//  SlideApp
//
//  Created by 小林 博久 on 10/11/16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PDFDocument.h"


@interface PDFDocument ()

@property (strong, nonatomic, readwrite) NSURL              *url;
@property (assign, nonatomic, readwrite) CGPDFDocumentRef   pdfRef;

@end


@implementation PDFDocument


- (id)initWithUrl:(NSURL *)url
{
	self = [super init];
	if (self != nil) {
		_url = [url retain];
	}

	return self;
}

- (void)dealloc
{
	[_url release];
	if (_pdfRef != NULL) {
		CGPDFDocumentRelease(_pdfRef);
	}

	[super dealloc];
}


- (CGPDFDocumentRef)pdfRef
{
	if (_pdfRef == NULL) {
		_pdfRef = CGPDFDocumentCreateWithURL((CFURLRef)_url);
		if (_pdfRef != NULL) {
			CGPDFDocumentRetain(_pdfRef);
		}
	}

	return _pdfRef;
}


- (void)releasePdfRef
{
	if (_pdfRef != NULL) {
		CGPDFDocumentRelease(_pdfRef);
		_pdfRef = NULL;
	}
}


- (size_t)numberOfPages
{
	return CGPDFDocumentGetNumberOfPages(self.pdfRef);
}

- (CGPDFPageRef)pageRef:(size_t)pageNumber
{
	return CGPDFDocumentGetPage(self.pdfRef, pageNumber);
}


@end
