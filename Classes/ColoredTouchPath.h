//
//  ColoredTouchPath.h
//  benpaint
//
//  Created by Heath Borders on 4/21/10.
//  Copyright 2010 Asynchrony Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ColoredTouchPath : NSObject {
	UITouch *_touch;
	
	NSMutableArray *_xMutableArray;
	NSMutableArray *_yMutableArray;
	
	NSNumber *_lastX;
	NSNumber *_lastY;
	
	CGFloat _red;
	CGFloat _green;
	CGFloat _blue;
	
	BOOL _touchEnded;
}

@property (nonatomic, retain) UITouch *touch;

@property (nonatomic, retain) NSMutableArray *xMutableArray;
@property (nonatomic, retain) NSMutableArray *yMutableArray;

@property (nonatomic, retain) NSNumber *lastX;
@property (nonatomic, retain) NSNumber *lastY;

@property (nonatomic) CGFloat red;
@property (nonatomic) CGFloat green;
@property (nonatomic) CGFloat blue;

@property (nonatomic) BOOL touchEnded;

- (void) addPointInView: (UIView *) view;
- (void) flushPoints;

@end
