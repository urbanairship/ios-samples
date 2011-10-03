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

+ (void)quitInbox
{
    [[self shared]quitInbox];
}

- (void)dealloc
{
    RELEASE_SAFELY(localizationBundle);
    RELEASE_SAFELY(tabBarController);
    RELEASE_SAFELY(alertHandler);
    RELEASE_SAFELY(mlc);
    RELEASE_SAFELY(badgeValue);
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
        
        /*
         * Step 1a: Setup tab bar controller and other initialization
         */
        
        // set the status bar to black
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    
    return self;
}


+ (void)displayInbox:(UIViewController *)viewController animated:(BOOL)animated
{
    /*
     * Step 1b: Display a list of messages
     */
}

- (void)quitInbox
{
    /*
     * Step 1c: Quit inbox.
     */
}

+ (void)displayMessage:(UIViewController *)viewController message:(NSString *)messageID
{
    /*
     * Step 1d: Display an individual message
     */
}

+ (void)loadLaunchMessage
{
    /*
     * Step 1e: Load a launch message, if any.
     */
}

@end
