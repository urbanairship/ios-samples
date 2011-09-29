//
//  UAInboxTabUI.h
//  TabBarInboxSample
//
//  Created by Jimmy Dee on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UAInbox.h"
#import "UAInboxPushHandler.h"

@interface UAInboxTabUI : NSObject<UAInboxUIProtocol>

- (void)quitInbox;

SINGLETON_INTERFACE(UAInboxTabUI);

@property (nonatomic, assign) BOOL useOverlay;
@property (nonatomic, retain) NSBundle* localizationBundle;
@property (nonatomic, retain) UITabBarController* tabBarController;

@end
