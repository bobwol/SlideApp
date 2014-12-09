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

@property (assign, nonatomic, readonly) BOOL isExternal;
@property (assign, nonatomic, readonly) int page;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             external:(BOOL)isExternal;

- (void)setContent:(PDFDocument *)content
			atPage:(int)page;

@end
