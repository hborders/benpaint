//
//  ColoredTouchPath.m
//  benpaint
//
//  Created by Heath Borders on 4/21/10.
//  Copyright 2010 Asynchrony Solutions, Inc. All rights reserved.
//

#import "ColoredTouchPath.h"

@interface ColoredTouchPath()

@end

@implementation ColoredTouchPath

@synthesize touch = _touch;

@synthesize xMutableArray = _xMutableArray;
@synthesize yMutableArray = _yMutableArray;

@synthesize lastX = _lastX;
@synthesize lastY = _lastY;

@synthesize red = _red;
@synthesize green = _green;
@synthesize blue = _blue;

@synthesize touchEnded = _touchEnded;

- (id) init {
	if (self = [super init]) {
		self.xMutableArray = [NSMutableArray arrayWithCapacity:8];
		self.yMutableArray = [NSMutableArray arrayWithCapacity:8];
		
		self.red = (float)random()/(float)LONG_MAX;
		self.blue = (float)random()/(float)LONG_MAX;
		self.green = (float)random()/(float)LONG_MAX;
	}
	
	return self;
}

- (void)dealloc {
	self.touch = nil;
	self.xMutableArray = nil;
	self.yMutableArray = nil;
	self.lastX = nil;
	self.lastY = nil;
	
    [super dealloc];
}

- (void) addPointInView: (UIView *) view {
	CGPoint locationInViewPoint = [self.touch locationInView: view];
	
	[self.xMutableArray addObject:[NSNumber numberWithFloat:locationInViewPoint.x]];
	[self.yMutableArray addObject:[NSNumber numberWithFloat:locationInViewPoint.y]];
}

- (void) flushPoints {
	if ([self.xMutableArray count]) {
		self.lastX = [self.xMutableArray lastObject];
		[self.xMutableArray removeAllObjects];
		self.lastY = [self.yMutableArray lastObject];
		[self.yMutableArray removeAllObjects];
	}
}

@end
