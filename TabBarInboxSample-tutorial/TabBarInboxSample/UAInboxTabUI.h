//
//  UAInboxTabUI.h
//  TabBarInboxSample
//
//  Created by Jimmy Dee on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "UAInbox.h"
#import "UAInboxPushHandler.h"

@class UAInboxAlertHandler;

@interface UAInboxTabUI : NSObject<UAInboxUIProtocol>

SINGLETON_INTERFACE(UAInboxTabUI);

- (void)quitInbox;

@property (nonatomic, retain) NSString* badgeValue;
@property (nonatomic, assign) BOOL useOverlay;
@property (nonatomic, retain) NSBundle* localizationBundle;
@property (nonatomic, retain) UITabBarController* tabBarController;

@end
