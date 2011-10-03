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
    
    
    //Init Airship launch options
    NSMutableDictionary *takeOffOptions = [[[NSMutableDictionary alloc] init] autorelease];
    [takeOffOptions setValue:launchOptions forKey:UAirshipTakeOffOptionsLaunchOptionsKey];
    
    // Create Airship singleton that's used to talk to Urban Airship servers.
    // Please populate AirshipConfig.plist with your info from http://go.urbanairship.com
    [UAirship takeOff:takeOffOptions];
    
    [self loadInbox];
  
    // Set the application to use the UAInboxSplitUI we've defined here.
    [UAInbox useCustomUI:[UAInboxTabUI class]];

    [self.window setRootViewController:[UAInboxTabUI shared].tabBarController];
    [self.window makeKeyAndVisible];
    
    [UAInboxTabUI shared].useOverlay = YES;
    [UAInbox shared].pushHandler.delegate = [UAInboxTabUI shared];
    
    [UAInboxPushHandler handleLaunchOptions:launchOptions];
    
    if([[UAInbox shared].pushHandler hasLaunchMessage]) {
        [[[UAInbox shared] uiClass] loadLaunchMessage];
    }
        
    return NO;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    UALOG(@"APN device token: %@", deviceToken);
    // Updates the device token and registers the token with UA
    [[UAirship shared] registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    UALOG(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    UAInbox *inbox = [UAInbox shared];
    if (inbox != nil && inbox.messageList != nil && inbox.messageList.unreadCount >= 0) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:inbox.messageList.unreadCount];
    }
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
    [self loadInbox];
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

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UAInboxPushHandler handleNotification:userInfo];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (void)loadInbox
{
    // Reload the message list when the app is foregrounded
    UAInbox *inbox = [UAInbox shared];
    if (inbox != nil && inbox.messageList != nil) {
        [inbox.messageList retrieveMessageList];
    }   
}

- (void)setInboxBadgeValue
{
    [[UAInboxTabUI shared] setCurrentBadgeNum];
}

@end
