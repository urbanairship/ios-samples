//
//  TabBarInboxSampleAppDelegate.m
//  TabBarInboxSample
//
//  Created by Jimmy Dee on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UAirship.h"
#import "UAInboxTabUI.h"
#import "UAInboxMessageList.h"
#import "TabBarInboxSampleAppDelegate.h"

@implementation TabBarInboxSampleAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Register for notifications
    [[UIApplication sharedApplication]
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound |
                                         UIRemoteNotificationTypeAlert)];
    
    /*
     * Step 2b: Initialize Airship and root view controller
     */
    
    [self.window makeKeyAndVisible];
    
    /*
     * Step 3b: Connect the push handler delegate
     */
    
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     * Step 2e: Display a badge number, if any
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     * Step 2d: Reload message list
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [UAirship land];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
