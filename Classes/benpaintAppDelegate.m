//
//  benpaintAppDelegate.m
//  benpaint
//
//  Created by Heath Borders on 4/19/10.
//  Copyright Asynchrony Solutions, Inc. 2010. All rights reserved.
//

#import "benpaintAppDelegate.h"
#import "MultitouchView.h"

@implementation benpaintAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Override point for customization after application launch
	[window addSubview:[[[MultitouchView alloc] initWithFrame:window.bounds] autorelease]];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
