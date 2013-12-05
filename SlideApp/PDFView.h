//
//  PDFView.h
//  SlideApp
//
//  Created by 小林 博久 on 10/11/16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PDFDocument;

@interface PDFView : UIView {
}

@property (strong, nonatomic, readonly) PDFDocument     *pdfDocument;
@property (assign, nonatomic, readonly) size_t          pageNumber;


- (id)initWithFrame:(CGRect)frame
        pdfDocument:(PDFDocument *)inDocument
         pageNumber:(size_t)inPageNumber;

@end
