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
        self.isVisible = NO;

        /*
         * TODO: Setup split view and other initialization
         */
    }
    
    return self;
}

- (void)quitInbox
{
    /*
     * TODO: Implement quitInbox
     */
    
}

+ (void)quitInbox
{
    [[UAInboxSplitUI shared] quitInbox];
}

+ (void)loadLaunchMessage
{
    /*
     * TODO: Display a launch message, if any
     */
    
}

+ (void)displayInbox:(UIViewController *)viewController animated:(BOOL)animated
{
    /*
     * TODO: Display the inbox view controller
     */
   
}

+ (void)displayMessage:(UIViewController *)viewController message:(NSString *)messageID
{
    /*
     * TODO: Display the requested message
     */
    
}

@end