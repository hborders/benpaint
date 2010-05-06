//
//  MultitouchView.h
//  benpaint
//
//  Created by Heath Borders on 4/19/10.
//  Copyright 2010 Asynchrony Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MultitouchView : UIView {
	CGLayerRef _layerRef;
	NSMutableArray *_coloredTouchPathsMutableArray;
}

@end
