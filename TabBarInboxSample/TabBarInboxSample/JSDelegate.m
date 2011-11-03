/*
 Copyright 2009-2011 Urban Airship Inc. All rights reserved.

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

#import <Foundation/Foundation.h>

#import "UAViewUtils.h"
#import "UAInboxAlertHandler.h"
#import "UAInbox.h"
#import "UAInboxPushHandler.h"
#import "UAInboxMessageListController.h"

#define UA_INBOX_TR(key) [[UAInboxUI shared].localizationBundle localizedStringForKey:key value:@"" table:nil]

/**
 * This class is the default rich push UI impelementation.  When it is
 * designated as the [UAInbox uiClass], launching the inbox will cause it
 * to be displayed in a modal view controller.
 */
@interface UAInboxUI : NSObject <UAInboxUIProtocol, UAInboxPushHandlerDelegate> {
  @private
    NSBundle *localizationBundle;
	UAInboxAlertHandler *alertHandler;
    UIViewController *rootViewController;
    UAInboxMessageListController *messageListController;
    UIViewController *inboxParentController;
    BOOL useOverlay;
    BOOL isVisible;
}

/**
 * Set this property to YES if the class should display in-app messages
 * using UAInboxOverlayController, and NO if it should navigate to the
 * inbox and display the message as though it had been selected.
 */
@property (nonatomic, assign) BOOL useOverlay;

/**
 * The parent view controller the inbox will be launched from.
 */
@property (nonatomic, retain) UIViewController *inboxParentController;

@property (nonatomic, retain) NSBundle *localizationBundle;

SINGLETON_INTERFACE(UAInboxUI);

///---------------------------------------------------------------------------------------
/// @name UAInboxUIProtocol Methods
///---------------------------------------------------------------------------------------
+ (void)quitInbox;
+ (void)displayInbox:(UIViewController *)viewController animated:(BOOL)animated;
+ (void)displayMessage:(UIViewController *)viewController message:(NSString*)messageID;
+ (void)loadLaunchMessage;

///---------------------------------------------------------------------------------------
/// @name UAInboxPushHandlerDelegate Methods
///---------------------------------------------------------------------------------------
- (void)newMessageArrived:(NSDictionary *)message;

@end
#import "JSDelegate.h"

@implementation JSDelegate

/**
 * Invoked when a message view controller or overlay controller tries to load a ua://
 * URL in its web view. The parameter is structured ua://host/arg1/arg2/...?key1=value1&key2=value2&....
 * The host portion is ignored. The path segments at the end are passed in the args
 * parameter as an array of NSString references. Any key-value pairs supplied in the
 * URL are passed in the options argument. All keys and values are NSString references.
 *
 * @param args an array of string arguments from the URL
 * @param options a dictionary of key-value pairs from the URL
 * @return JavaScript to be evaluated in the web view. nil on error.
 */
- (NSString*)callbackArguments:(NSArray *)args withOptions:(NSDictionary *)options
{   
    /*
     * Must have the format ua://whocares/JSGlobalVarName?fields=field1,field2
     * The field names must be chosen from deviceName and systemVersion. Failure to
     * supply a variable name or a field list will result in an error.
     */
    
    NSString* varName = [args objectAtIndex:0];
    if (varName == nil) {
        UALOG(@"no variable name provided, can't respond to user");
        return nil;
    }
    
    NSString* fields = [options valueForKey:@"fields"];
    if (fields == nil) {
        return [NSString stringWithFormat:@"%@.error = 'missing fields parameter'; %@.onFinished();", varName, varName];
    }
    
    bool error = false;
    
    /*
     * Now tokenize the field list using a comma separator.
     */
    NSArray* fieldList = [fields componentsSeparatedByString:@","];
    
    NSString* response = [NSString string];
    UIDevice* device = [UIDevice currentDevice];
    
    /*
     * Add each requested property.
     */
    for (int j=0; !error && j<fieldList.count; ++j) {
        NSString* field = [fieldList objectAtIndex:j];
        if ([field isEqualToString:@"deviceName"]) {
            response = [response stringByAppendingFormat:@"%@.deviceName = \"%@\";", varName, [device name]];
        }
        else if ([field isEqualToString:@"systemVersion"]) {
            response = [response stringByAppendingFormat:@"%@.systemVersion = \"%@\";", varName, [device systemVersion]];
        }
        else {
            error = true;
        }
    }
    
    if (!error) {
        return [response stringByAppendingFormat:@"%@.onFinished();", varName];
    }
    else {
        return [NSString stringWithFormat:@"%@.error = 'invalid field'; %@.onFinished();", varName, varName];
    }
}

@end
