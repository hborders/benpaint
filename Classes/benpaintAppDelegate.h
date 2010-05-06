//
//  benpaintAppDelegate.h
//  benpaint
//
//  Created by Heath Borders on 4/19/10.
//  Copyright Asynchrony Solutions, Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface benpaintAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

