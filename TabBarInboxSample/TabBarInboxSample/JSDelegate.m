//
//  JSDelegate.m
//  TabBarInboxSample
//
//  Created by Jimmy Dee on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
        return [NSString stringWithFormat:@"%@.error = 'missing fields parameter'; %@.finishedLoading();", varName, varName];
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
        return [response stringByAppendingFormat:@"%@.finishedLoading();", varName];
    }
    else {
        return [NSString stringWithFormat:@"%@.error = 'invalid field'; %@.finishedLoading();", varName, varName];
    }
}

@end
