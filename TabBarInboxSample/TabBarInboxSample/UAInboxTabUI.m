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
        
        /*
         * TODO: Setup tab bar controller and other initialization
         */
    }
    
    return self;
}

- (void)quitInbox
{
    /*
     * TODO: Quit inbox.
     */
}

+ (void)quitInbox
{
    [[self shared]quitInbox];
}

+ (void)loadLaunchMessage
{
    /*
     * TODO: Load a launch message, if any.
     */
}

+ (void)displayInbox:(UIViewController *)viewController animated:(BOOL)animated
{
    /*
     * TODO: Display a list of messages
     */
}

+ (void)displayMessage:(UIViewController *)viewController message:(NSString *)messageID
{
    /*
     * TODO: Display an individual message
     */
}

@end
