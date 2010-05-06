//
//  MultitouchView.m
//  benpaint
//
//  Created by Heath Borders on 4/19/10.
//  Copyright 2010 Asynchrony Solutions, Inc. All rights reserved.
//

#import "MultitouchView.h"
#import "ColoredTouchPath.h"

@interface MultitouchView()

@property (nonatomic) CGLayerRef layerRef;
@property (nonatomic, retain) NSMutableArray *coloredTouchPathsMutableArray;

- (ColoredTouchPath *) findColoredTouchPathForTouch: (UITouch *) touch;

@end


@implementation MultitouchView

@synthesize layerRef = _layerRef;
@synthesize coloredTouchPathsMutableArray = _coloredTouchPathsMutableArray;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.multipleTouchEnabled = YES;
		self.opaque = YES;
		self.layerRef = NULL;
		self.coloredTouchPathsMutableArray = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}

- (void)dealloc {
	CGLayerRelease(self.layerRef);
	self.coloredTouchPathsMutableArray = nil;
	
    [super dealloc];
}

- (void) drawRect:(CGRect)rect {
	CGContextRef graphicsContextRef = UIGraphicsGetCurrentContext();
	BOOL layerRefCreated = NO;
	if (self.layerRef == NULL) {
		self.layerRef = CGLayerCreateWithContext(graphicsContextRef, self.bounds.size, NULL);
		layerRefCreated = YES;
	}
	
	CGContextRef layerContextRef = CGLayerGetContext(self.layerRef);
	if (layerRefCreated) {
		CGContextSetRGBFillColor(layerContextRef, 1, 1, 1, 1);
		CGContextFillRect(layerContextRef, self.bounds);
	}	
	
	NSMutableArray *coloredTouchPathsToRemoveMutableArray = [NSMutableArray arrayWithCapacity:5];
	for (ColoredTouchPath *coloredTouchPath in self.coloredTouchPathsMutableArray) {
		if ([coloredTouchPath.xMutableArray count]) {
			if (([coloredTouchPath.xMutableArray count] == 1) && !coloredTouchPath.lastX) {
				CGFloat x = [[coloredTouchPath.xMutableArray objectAtIndex:0] floatValue];
				CGFloat y = [[coloredTouchPath.yMutableArray objectAtIndex:0] floatValue];
				
				CGContextSetRGBFillColor(layerContextRef, coloredTouchPath.red, coloredTouchPath.green, coloredTouchPath.blue, 1);
				CGContextFillRect(layerContextRef, CGRectMake(x-5, y-5, 10, 10));
			} else {
				CGContextSetRGBStrokeColor(layerContextRef, coloredTouchPath.red, coloredTouchPath.green, coloredTouchPath.blue, 1);
				CGContextBeginPath(layerContextRef);
				CGContextMoveToPoint(layerContextRef, [coloredTouchPath.lastX floatValue], [coloredTouchPath.lastY floatValue]);
				CGContextSetLineWidth(layerContextRef, 10);
				CGContextSetLineCap(layerContextRef, kCGLineCapRound);
				CGContextSetLineJoin(layerContextRef, kCGLineJoinRound);
				for (NSUInteger i = 0; i < [coloredTouchPath.xMutableArray count]; i++) {
					CGFloat x = [[coloredTouchPath.xMutableArray objectAtIndex:i] floatValue];
					CGFloat y = [[coloredTouchPath.yMutableArray objectAtIndex:i] floatValue];
					CGContextAddLineToPoint(layerContextRef, x, y);
				}		
				CGContextStrokePath(layerContextRef);
			}
		}
		
		[coloredTouchPath flushPoints];
		if (coloredTouchPath.touchEnded) {
			[coloredTouchPathsToRemoveMutableArray addObject:coloredTouchPath];
		}
	}
	
	[self.coloredTouchPathsMutableArray removeObjectsInArray:coloredTouchPathsToRemoveMutableArray];
	
	CGContextDrawLayerAtPoint(graphicsContextRef, CGPointMake(0, 0), self.layerRef);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {	
	for (UITouch *touch in touches) {
		ColoredTouchPath *coloredTouchPath = [[[ColoredTouchPath alloc] init] autorelease];
		coloredTouchPath.touch = touch;
		[coloredTouchPath addPointInView:self];
		[self.coloredTouchPathsMutableArray addObject:coloredTouchPath];
	}
	
	[self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {	
	for (UITouch *touch in touches) {
		ColoredTouchPath *coloredTouchPath = [self findColoredTouchPathForTouch:touch];
		[coloredTouchPath addPointInView:self];
	}
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in touches) {
		ColoredTouchPath *coloredTouchPath = [self findColoredTouchPathForTouch:touch];
		coloredTouchPath.touchEnded = YES;
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (ColoredTouchPath *) findColoredTouchPathForTouch: (UITouch *) touch {
	for (ColoredTouchPath *coloredTouchPath in self.coloredTouchPathsMutableArray) {
		if ([coloredTouchPath.touch isEqual:touch]) {
			return coloredTouchPath;
		}
	}
	
	return nil;
}

@end
