//
//  AppDelegate.h
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RootViewController;
@class ExternalViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet RootViewController *rootViewController;

@property (strong, nonatomic) UIWindow			*extWindow;
@property (strong, nonatomic) ExternalViewController *externalViewController;
@property (assign, nonatomic, readonly) CGRect  extFrame;

+ (AppDelegate *)getAppDelegate;

@end
