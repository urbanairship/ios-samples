/*
 Copyright 2009-2012 Urban Airship Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binaryform must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided withthe distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE URBAN AIRSHIP INC ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL URBAN AIRSHIP INC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
        
        self.isVisible = NO;
        
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

- (void)tabBarController:(UITabBarController *)theTabBarController didSelectViewController:(UIViewController *)viewController
{
    if (viewController == mlc) {
        [[self class]displayInbox:theTabBarController animated:YES];
    }
    else {
        [[self class]quitInbox];
    }
}

@end
