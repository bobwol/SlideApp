//
//  ExternalViewController.h
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExternalViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

- (IBAction)onLeftButton:(id)sender;
- (IBAction)onRightButton:(id)sender;
- (IBAction)onTopButton:(id)sender;

- (void)toPage:(int)page;

@end
