//
//  UAInboxSplitUI.m
//  SplitViewInboxSample
//
//  Created by Jimmy Dee on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UAInboxSplitUI.h"
#import "UAInboxMessageList.h"
#import "UAInboxMessageListController.h"
#import "UAInboxMessageViewController.h"
#import "UAInboxUI.h"

@interface UAInboxSplitUI ()

@property (nonatomic, retain) UAInboxAlertHandler *alertHandler;
@property (nonatomic, retain) UAInboxMessageListController* mlc;
@property (nonatomic, retain) UAInboxMessageViewController* mvc;
@property (nonatomic, assign) BOOL isVisible;

@end

@implementation UAInboxSplitUI
@synthesize useOverlay;
@synthesize localizationBundle;
@synthesize splitViewController;
@synthesize alertHandler;
@synthesize isVisible;
@synthesize mlc;
@synthesize mvc;

SINGLETON_IMPLEMENTATION(UAInboxSplitUI);

- (void)dealloc
{
    RELEASE_SAFELY(localizationBundle);
    RELEASE_SAFELY(alertHandler);
    RELEASE_SAFELY(splitViewController);
    RELEASE_SAFELY(mvc);
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

        // Set up the list and message view controllers for the master and detail panels, respectively.
        mlc = [[UAInboxMessageListController alloc] initWithNibName:@"UAInboxMessageListController" bundle:nil];
        mvc = [[UAInboxMessageViewController alloc] initWithNibName:@"UAInboxMessageViewController" bundle:nil];

        // Set up the main split view controller
        splitViewController = [[UISplitViewController alloc]init];
        splitViewController.viewControllers = [NSArray arrayWithObjects:mlc, mvc, nil];

        // Handler for rich push notification
        alertHandler = [[UAInboxAlertHandler alloc] init];
    }
    
    return self;
}

- (void)quitInbox
{
    self.isVisible = NO;
}

+ (void)quitInbox
{
    [[UAInboxSplitUI shared] quitInbox];
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
    [self shared].isVisible = YES;
}

+ (void)displayMessage:(UIViewController *)viewController message:(NSString *)messageID
{
    NSLog(@"displaying message %@", messageID);
    [[UAInboxSplitUI shared].mvc loadMessageForID:messageID];
}

- (void)newMessageArrived:(NSDictionary *)message
{
    NSString* alertText = [[message objectForKey: @"aps"] objectForKey: @"alert"];
    UALOG(@"new message received: %@", alertText);
    [alertHandler showNewMessageAlert:alertText];
}
@end