//
//  PushNotification.h
//  urbanairship.richpush
//
//  Created by urbanairship on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface PushNotification : CDVPlugin {
    NSString* callbackID;  
}

@property (nonatomic, copy) NSString* callbackID;

// Instance Method  
- (void) print:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end
