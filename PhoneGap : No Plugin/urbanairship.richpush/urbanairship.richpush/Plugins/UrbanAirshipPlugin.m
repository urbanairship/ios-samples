//
//  UrbanAirshipPlugin.m
//  urbanairship.richpush
//
//  Created by urbanairship on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UrbanAirshipPlugin.h"
#import "UAPush.h"

@implementation UrbanAirshipPlugin 

@synthesize callbackID;

- (void)printAlias:(NSMutableArray*)aliasArguments withDict:(NSMutableDictionary*)options  {
    // The first argument in the arguments parameter is the callbackID.
    // We use this to send data back to the successCallback or failureCallback
    // through PluginResult
    self.callbackID = [aliasArguments pop];
    
    // Get the string that javascript sent us
    NSString *aliasStringObtainedFromJavascript = [aliasArguments objectAtIndex:0];                 
    
    // setting updateALias to the string that was recieved
    [[UAPush shared] updateAlias:aliasStringObtainedFromJavascript];
    
    // Create Plugin Result 
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString: [aliasStringObtainedFromJavascript stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Call the javascript success function
    [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
}

- (void)printTags:(NSMutableArray *)tagsArguments withDict:(NSMutableDictionary *)options {
    // Idea: Bring the string in as a whole, use http://stackoverflow.com/questions/9057583/comma-separated-string-to-nsarray-in-objective-c or something similar to split with comma's, then put into NSMutableArray...
    
    // The first argument in the arguments parameter is the callbackID.
    // We use this to send data back to the successCallback or failureCallback
    // through PluginResult
    self.callbackID = [tagsArguments pop];
    
    // Get the string that javascript sent us
    NSString *tagsStringObtainedFromJavascript = [tagsArguments objectAtIndex:0];                 
    
    // Moving Alias String into immutable array and separate by comma's
    NSMutableArray *tagsArrayObtainedFromString = [[tagsStringObtainedFromJavascript componentsSeparatedByString:@","] mutableCopy];
    
    // setting updateALias to the string that was recieved
    [[UAPush shared] updateTags:tagsArrayObtainedFromString];
    
    // Create Plugin Result 
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString: [tagsStringObtainedFromJavascript stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Call the javascript success function
    [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
}


@end