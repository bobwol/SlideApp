//
//  AppDelegate.m
//  SlideApp
//
//  Created by 小林 博久 on 13/12/04.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "ExternalViewController.h"


static AppDelegate *sAppDelegate;


@interface AppDelegate ()

@property (assign, nonatomic, readwrite) CGRect  extFrame;

- (void)handleScreenDidConnect:(NSNotification *)aNotification;
- (void)handleScreenDidDisconnect:(NSNotification *)aNotification;

@end


@implementation AppDelegate


+ (AppDelegate *)getAppDelegate
{
    return sAppDelegate;
}


- (ExternalViewController *)externalViewController;
{
    if (_externalViewController == nil) {
        _externalViewController = [[ExternalViewController alloc] initWithNibName:@"ExternalViewController"
                                                                           bundle:nil];
    }

    return _externalViewController;
}


- (void)dealloc
{
    [_externalViewController release];

    [super dealloc];
}


- (BOOL)application:(UIApplication *)application
 didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    sAppDelegate = self;

    [UIApplication sharedApplication].idleTimerDisabled = YES;

    [self setupNotification];
    [self setupMainWindow];
    [self autoSetupExtWindow];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self removeNotification];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self removeNotification];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self setupNotification];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self setupNotification];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self removeNotification];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
}


#pragma mark -
#pragma mark handle notification

- (void)setupNotification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(handleScreenDidConnect:)
                   name:UIScreenDidConnectNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(handleScreenDidDisconnect:)
                   name:UIScreenDidDisconnectNotification
                 object:nil];
}

- (void)removeNotification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center removeObserver:self
                      name:UIScreenDidConnectNotification
                    object:nil];
    
    [center removeObserver:self
                      name:UIScreenDidDisconnectNotification
                    object:nil];
    
    [self closeExtWindow];
}

- (void)handleScreenDidConnect:(NSNotification *)aNotification
{
    [self autoSetupExtWindow];
}

- (void)handleScreenDidDisconnect:(NSNotification *)aNotification
{
    [self closeExtWindow];
}


#pragma mark -
#pragma mark handle windows

- (void)setupMainWindow
{
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
}

- (BOOL)extWindowEnabled
{
    return self.extWindow != nil;
}

- (BOOL)setupExtWindowWithScreen:(UIScreen *)screen
                            mode:(UIScreenMode *)mode
{
    screen.currentMode = mode;
    
    self.extFrame = CGRectMake(0.0, 0.0, mode.size.width, mode.size.height);
    self.extWindow = [[[UIWindow alloc] initWithFrame:self.extFrame] autorelease];
    self.extWindow.screen = screen;
    self.extWindow.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.extWindow makeKeyAndVisible];

    self.extWindow.rootViewController = self.externalViewController;

    return YES;
}

- (void)closeExtWindow
{
    self.extWindow.rootViewController = nil;
    self.extWindow = nil;
    self.extFrame = CGRectMake(0.0, 0.0, 0.0, 0.0);
}


- (void)autoSetupExtWindow
{
    // select external screen
    UIScreen *extScreen = nil;
    
    NSArray	*screens = [UIScreen screens];
    int screenCount = (int)screens.count;
    for (int i = 1; i < screenCount; i++) {		// index:0 - main screen
        UIScreen *screen = [screens objectAtIndex:i];
        if (screen != nil) {
            extScreen = screen;
            break;
        }
    }
    
    if (extScreen != nil) {
        // set overscan compensation
        //extScreen.overscanCompensation = UIScreenOverscanCompensationInsetApplicationFrame;
        extScreen.overscanCompensation = 3;		// undocumented number!
        
        // select max width mode
        UIScreenMode *maxMode = extScreen.currentMode;
        int maxWidth = maxMode.size.width;
        
        NSArray	*modes = [extScreen availableModes];
        for (UIScreenMode *mode in modes) {
            if (mode.size.width > maxWidth) {
                maxWidth = mode.size.width;
                maxMode = mode;
            }
        }
        
        if (maxMode != nil) {
            NSLog(@"%@", NSStringFromCGSize(maxMode.size));
            [self setupExtWindowWithScreen:extScreen
                                      mode:maxMode];
        }
    }
}

@end
