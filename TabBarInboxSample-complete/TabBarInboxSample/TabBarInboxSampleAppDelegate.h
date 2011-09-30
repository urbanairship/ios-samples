//
//  TabBarInboxSampleAppDelegate.h
//  TabBarInboxSample
//
//  Created by Jimmy Dee on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarInboxSampleAppDelegate : NSObject <UIApplicationDelegate>

- (void)loadInbox;
- (void)setInboxBadgeValue;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
