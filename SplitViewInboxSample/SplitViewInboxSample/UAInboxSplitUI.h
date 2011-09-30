//
//  UAInboxSplitUI.h
//  SplitViewInboxSample
//
//  Created by Jimmy Dee on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UAInbox.h"
#import "UAInboxPushHandler.h"

@class UAInboxAlertHandler;

@interface UAInboxSplitUI : NSObject<UAInboxUIProtocol, UAInboxPushHandlerDelegate>

SINGLETON_INTERFACE(UAInboxSplitUI);

@property (nonatomic, assign) BOOL useOverlay;
@property (nonatomic, retain) NSBundle* localizationBundle;
@property (nonatomic, retain) UISplitViewController* splitViewController;

@end
