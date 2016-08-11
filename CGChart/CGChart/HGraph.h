//
//  HGraph.h
//  CGChart
//
//  Created by Tran Hai Linh on 8/11/16.
//  Copyright © 2016 THL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HGraph : NSObject

#pragma mark properties
@property (nonatomic) NSString* gId;
@property (nonatomic) int index;
@property (nonatomic) double value;
@property (nonatomic) double maxValue;
@property (nonatomic) BOOL highlighted;
@property (nonatomic) int totalGraphs;
@property (nonatomic) NSDictionary* config;

// for draw
@property (nonatomic) UIBezierPath* bezierPath;
@property (nonatomic) CGRect rect;  // rect which draw on
@property (nonatomic) CGRect frame; // frame of the graph, day la frame doi voi do thi, ko phai doi voi toa do cua Iphone
//@property (nonatomic,readonly) CGRect originFrame;   // frame doi voi toa do cua Iphone
@property (nonatomic) CGSize maxSize;  // max size which can draw frame on

#pragma mark Funtions
- (void) setFirstFrame;
- (void) draw;
- (void) updateGraph:(double) interval;
- (BOOL) containtPoint:(CGPoint) point;
@end
