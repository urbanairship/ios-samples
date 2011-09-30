//
//  UAInboxTabUI.m
//  TabBarInboxSample
//
//  Created by Jimmy Dee on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "UAInboxAlertHandler.h"
#import "UAInboxMessageList.h"
#import "UAInboxMessageListController.h"
#import "UAInboxOverlayController.h"
#import "UAInboxTabUI.h"

@interface UAInboxTabUI ()

@property (nonatomic, retain) UAInboxAlertHandler *alertHandler;
@property (nonatomic, retain) UAInboxMessageListController* mlc;
@property (nonatomic, assign) BOOL isVisible;

@end


@implementation UAInboxTabUI

@synthesize useOverlay;
@synthesize localizationBundle;
@synthesize tabBarController;
@synthesize isVisible;
@synthesize alertHandler;
@synthesize mlc;
@synthesize badgeValue;

SINGLETON_IMPLEMENTATION(UAInboxTabUI);

- (void)dealloc
{
    RELEASE_SAFELY(localizationBundle);
    RELEASE_SAFELY(tabBarController);
    RELEASE_SAFELY(alertHandler);
    RELEASE_SAFELY(mlc);
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Basic initialization
        NSString* path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"UAInboxLocalization.bundle"];
        self.localizationBundle = [NSBundle bundleWithPath:path];
        
        self.useOverlay = NO;
        self.isVisible = YES;
        
        // Set up alert handler
        alertHandler = [[UAInboxAlertHandler alloc]init];
        
        // Set up tabs and tab bar controller
        UIImage* clockImage = [UIImage imageNamed:@"clock.png"];
        UIImage* inboxImage = [UIImage imageNamed:@"inbox.png"];
        
        MainViewController* main = [[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil]autorelease];
        UITabBarItem* mainBarItem = [[[UITabBarItem alloc]initWithTitle:@"Time" image:clockImage tag:0]autorelease];
        main.tabBarItem = mainBarItem;
        
        mlc = [[UAInboxMessageListController alloc]initWithNibName:@"UAInboxMessageListController" bundle:nil];
        UITabBarItem* inboxBarItem = [[[UITabBarItem alloc]initWithTitle:@"Inbox" image:inboxImage tag:1]autorelease];
        mlc.tabBarItem = inboxBarItem;
        
        tabBarController = [[UITabBarController alloc]init];
        tabBarController.viewControllers = [NSArray arrayWithObjects:main, mlc, nil];
        
        // add myself as a message list observer so I know when things change
        [[UAInbox shared].messageList addObserver:self];
        
        // set the status bar to black
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    
    return self;
}

- (void)quitInbox
{
    self.isVisible = NO;
}

+ (void)quitInbox
{
    [[self shared]quitInbox];
}

+ (void)loadLaunchMessage {
    // if pushhandler has a messageID load it
    UAInboxPushHandler *pushHandler = [UAInbox shared].pushHandler;
    if (pushHandler.viewingMessageID && pushHandler.hasLaunchMessage) {
        UAInboxMessage *msg = [[UAInbox shared].messageList messageForID:pushHandler.viewingMessageID];
        if (!msg) {
            return;
        }
        
        [UAInbox displayMessage:[self shared].mlc message:pushHandler.viewingMessageID];
        
        pushHandler.viewingMessageID = nil;
        pushHandler.hasLaunchMessage = NO;
    }
}

+ (void)displayInbox:(UIViewController *)viewController animated:(BOOL)animated
{
    UALOG(@"displayInbox:");
    [self shared].isVisible = YES;
    [[self shared]setCurrentBadgeNum];
}

+ (void)displayMessage:(UIViewController *)viewController message:(NSString *)messageID
{
    [UAInboxOverlayController showWindowInsideViewController:[self shared].tabBarController withMessageID:messageID];
}

- (void)newMessageArrived:(NSDictionary *)message {
    UALOG(@"newMessageArrived:");
    
    NSString* alertText = [[message objectForKey: @"aps"] objectForKey: @"alert"];
    [alertHandler showNewMessageAlert:alertText];
    
    NSNumber* badge = [[message objectForKey: @"aps"] objectForKey: @"badge"];
    if (badge != nil) {
        int badgeNum = badge.intValue;
        UALOG(@"badge = %d", badgeNum);
        if (badgeNum > 0) {
            [self setBadgeValue:[NSString stringWithFormat:@"%d", badgeNum]];
        }
        else {
            [self setBadgeValue:nil];
        }
    }
}

- (void)setBadgeValue:(NSString*)theBadgeValue
{
    /*
     * This method has retain semantics. The value is retained and released
     * by the UITabBarItem.
     */
    mlc.tabBarItem.badgeValue = theBadgeValue;
    [mlc.tabBarController.view setNeedsDisplay];
}

- (NSString*)badgeValue
{
    return mlc.tabBarItem.badgeValue;
}

- (void)setCurrentBadgeNum
{
    int badgeNum = [UAInbox shared].messageList.unreadCount;
    UALOG(@"badge = %d", badgeNum);
    if (badgeNum > 0) {
        [self setBadgeValue:[NSString stringWithFormat:@"%d", badgeNum]];
    }
    else {
        [self setBadgeValue:nil];
    }
}

- (void)messageListLoaded
{
    UALOG(@"messageListLoaded:");
    [self setCurrentBadgeNum];
}

- (void)singleMessageMarkAsReadFinished:(UAInboxMessage *)message
{
    UALOG(@"singleMessageMarkAsReadFinished:");
    [self setCurrentBadgeNum];
}

- (void)batchDeleteFinished
{
    UALOG(@"batchDeleteFinished");
    [self setCurrentBadgeNum];
}

- (void)batchMarkAsReadFinished
{
    UALOG(@"batchMarkAsReadFinished");
    [self setCurrentBadgeNum];   
}

@end
