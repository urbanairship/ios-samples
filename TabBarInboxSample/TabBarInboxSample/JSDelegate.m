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
    NSString* deviceName = [[UIDevice currentDevice] name];
    return [NSString stringWithFormat:@"var span = document.getElementById('device_name'); span.innerHTML = \"%@\";", deviceName];
}

@end
