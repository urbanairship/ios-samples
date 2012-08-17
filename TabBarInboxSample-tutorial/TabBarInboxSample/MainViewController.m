//
//  MainViewController.m
//  TabBarInboxSample
//
//  Created by Jimmy Dee on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UAirship.h"
#import "MainViewController.h"

@implementation MainViewController
@synthesize timer;
@synthesize timeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTimeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self displayCurrentTime];
    UALOG(@"viewWillAppear: scheduling timer");
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(displayCurrentTime) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    UALOG(@"viewDidDisappear: canceling timer");
    [self.timer invalidate];
    self.timer = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [timeLabel release];
    [super dealloc];
}

- (void)displayCurrentTime
{
    char buffer[256];
    struct tm tmbuf;
    time_t now;
    
    time(&now);
    localtime_r(&now, &tmbuf);
    strftime(buffer, 255, "%H:%M:%S", &tmbuf);
    
    NSString* timeValue = [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
    
    timeLabel.text = timeValue;
    [timeLabel setNeedsDisplay];
}
@end
