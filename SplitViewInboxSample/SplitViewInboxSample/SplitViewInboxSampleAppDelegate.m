//
//  SplitViewInboxSampleAppDelegate.m
//  SplitViewInboxSample
//
//  Created by Jimmy Dee on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UAirship.h"
#import "UAInboxSplitUI.h"
#import "UAInboxMessageList.h"
#import "SplitViewInboxSampleAppDelegate.h"

@implementation SplitViewInboxSampleAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Register for notifications
    [[UIApplication sharedApplication]
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound |
                                         UIRemoteNotificationTypeAlert)];
    
    /*
     * TODO: Initialize Airship and root view controller
     */

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     * TODO: Set an icon badge number, if any.
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
     * TODO: Reload inbox messages
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    //TODO: clean up all UI classes
    
    [UAirship land];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
