//
//  MainViewController.h
//  TabBarInboxSample
//
//  Created by Jimmy Dee on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController {
    UITextView *timeTextView;
    UILabel *timeLabel;
}

- (void)displayCurrentTime;

@property (nonatomic, retain) NSTimer* timer;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

@end
