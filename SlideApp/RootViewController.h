//
//  RootViewController.h
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) IBOutlet UIView *controlPanel;


- (IBAction)onLeftButton:(id)sender;
- (IBAction)onRightButton:(id)sender;
- (IBAction)onTopButton:(id)sender;

@end
