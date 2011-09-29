//
//  UAInboxTabUI.m
//  TabBarInboxSample
//
//  Created by Jimmy Dee on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UAInboxAlertHandler.h"
#import "UAInboxMessageListController.h"
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
@synthesize alertHandler;
@synthesize mlc;
@synthesize isVisible;

SINGLETON_IMPLEMENTATION(UAInboxTabUI);

- (void)dealloc
{
    RELEASE_SAFELY(tabBarController);
    RELEASE_SAFELY(alertHandler);
    RELEASE_SAFELY(mlc);
    RELEASE_SAFELY(localizationBundle);
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
         * Tab bar initialization is done in the NIB file. Here you can make minor tweaks.
         */
    }
    
    return self;
}

- (void) quitInbox
{
    /*
     * TODO: Close the inbox.
     */
}

+ (void) quitInbox
{
    [[self shared] quitInbox];
}

+ (void) loadLaunchMessage
{
    /*
     * TODO: Load a launch message, if any.
     */
}

+ (void) displayInbox:(UIViewController *)viewController animated:(BOOL)animated
{
    /*
     * TODO: Display a list of messages.
     */
}

+ (void) displayMessage:(UIViewController *)viewController message:(NSString *)messageID
{
    /*
     * TODO: Display an individual message.
     */
}

@end
