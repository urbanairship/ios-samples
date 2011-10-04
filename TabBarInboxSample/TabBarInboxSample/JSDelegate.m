//
//  JSDelegate.m
//  TabBarInboxSample
//
//  Created by Jimmy Dee on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSDelegate.h"

@implementation JSDelegate

- (NSString*)callbackArguments:(NSArray *)args withOptions:(NSDictionary *)options
{    
    NSString* varName = [args objectAtIndex:0];
    if (varName == nil) {
        UALOG(@"no variable name provided, can't respond to user");
        return nil;
    }
    
    NSString* fields = [options valueForKey:@"fields"];
    if (fields == nil) {
        return [NSString stringWithFormat:@"%@.error = 'missing fields parameter'; %@.finishedLoading();", varName, varName];
    }
    
    bool error = false;
    NSArray* fieldList = [fields componentsSeparatedByString:@","];
    
    NSString* response = [NSString string];
    UIDevice* device = [UIDevice currentDevice];
    
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
        return [response stringByAppendingFormat:@"%@.finishedLoading();", varName];
    }
    else {
        return [NSString stringWithFormat:@"%@.error = 'invalid field'; %@.finishedLoading();", varName, varName];
    }
}

@end
