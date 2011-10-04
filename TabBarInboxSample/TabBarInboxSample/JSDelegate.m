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
    NSString* deviceName = [[UIDevice currentDevice] name];
    return [NSString stringWithFormat:@"%@.deviceName = \"%@\"; %@.finishedLoading();", varName, deviceName, varName];
}

@end
