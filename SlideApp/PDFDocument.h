//
//  PDFDocument.h
//  SlideApp
//
//  Created by 小林 博久 on 10/11/16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PDFDocument : NSObject {
}

@property (strong, nonatomic, readonly) NSURL				*url;
@property (assign, nonatomic, readonly) CGPDFDocumentRef	pdfRef;


- (id)initWithUrl:(NSURL *)url;

- (void)releasePdfRef;

- (size_t)numberOfPages;
- (CGPDFPageRef)pageRef:(size_t)pageNumber;

@end
