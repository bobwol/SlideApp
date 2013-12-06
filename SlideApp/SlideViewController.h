//
//  SlideViewController.h
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFDocument.h"


@interface SlideViewController : UIViewController

@property (assign, nonatomic, readonly) int page;

- (void)setContent:(PDFDocument *)content
			atPage:(int)page;

@end