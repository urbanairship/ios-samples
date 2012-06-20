//
//  UrbanAirshipPlugin.h
//  urbanairship.richpush
//
//  Created by urbanairship on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface UrbanAirshipPlugin : CDVPlugin {
    NSString* callbackID;  
}

@property (nonatomic, copy) NSString* callbackID;

// Instance methods to update (replace) token attributes
- (void) printAlias:(NSMutableArray*)aliasArguments withDict:(NSMutableDictionary*)options;
- (void) printTags:(NSMutableArray*)tagsArguments withDict:(NSMutableDictionary*)options;

@end