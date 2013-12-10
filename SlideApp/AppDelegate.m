//
//  AppDelegate.m
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (void)dealloc
{
    [_rootViewController release];
    [_coverViewController release];
	[_window release];

    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[UIApplication sharedApplication].idleTimerDisabled = YES;

//	self.window.rootViewController = self.rootViewController;
	self.window.rootViewController = self.coverViewController;
	[self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
}

@end
