//
//  PushNotification.m
//  urbanairship.richpush
//
//  Created by urbanairship on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PushNotification.h"

@implementation PushNotification

@synthesize callbackID;

-(void)print:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options  
{
    // The first argument in the arguments parameter is the callbackID.
    // We use this to send data back to the successCallback or failureCallback
    // through PluginResult
    self.callbackID = [arguments pop];
    
    // Get the string that javascript sent us
    NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];                 
    
    // Create the Message that we wish to send to javascript
    NSMutableString *stringToReturn = [NSMutableString stringWithString: @"StringReceived:"];
    
    // Append the received string to the string we plan to send out        
    [stringToReturn appendString: stringObtainedFromJavascript];
    
    // Create Plugin Result 
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString: [stringToReturn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Checking if the string received is HelloWorld or not
    if ([stringObtainedFromJavascript isEqualToString:@"HelloWorld"] == YES)
    {
        // Call the javascript success function
        [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
    } else
    {    
        // Call the javascript error function
        [self writeJavascript: [pluginResult toErrorCallbackString:self.callbackID]];
    }
}
@end