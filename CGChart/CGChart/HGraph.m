//
//  HGraph.m
//  CGChart
//
//  Created by Tran Hai Linh on 8/11/16.
//  Copyright © 2016 THL. All rights reserved.
//

#import "HGraph.h"

@implementation HGraph

#pragma mark init
- (id)init
{
    if ((self = [super init]))
    {
        self.frame = CGRectZero;
        self.gId = @"";
        self.maxValue = 1;
    }
    return self;
}

#pragma mark Funtions
// set frame
- (void) setFirstFrame
{
}


- (void) updateGraph:(double) interval
{
    
};
- (void) draw
{
    // draw backgoround
    [self drawBackground];
    
    // validate frame
    [self validateFrame];
    
    // draw graph
    [self drawGraph];
    
    // draw value text
    [self drawTextValue];
    
    // draw name text
    [self drawTextName];
    
    // draw highlight
    if (self.highlighted) {
        [self drawHighlight];
    }
    
}

// validate frame
- (void) validateFrame
{
}

// draw backgoround
- (void) drawBackground
{
}

// draw graph
- (void) drawGraph
{
}

// draw value text
- (void) drawTextValue
{
}

// draw name text
- (void) drawTextName
{
}

// draw highlight
- (void) drawHighlight
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *knobPath =  [self.bezierPath copy];
    // fill
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.0 alpha:0.1].CGColor);
    CGContextAddPath(ctx, knobPath.CGPath);
    CGContextFillPath(ctx);
}

// check if bezierPath contain a point
- (BOOL) containtPoint:(CGPoint) point
{
    if (self.bezierPath) {
        
        return [self.bezierPath containsPoint:point];
    }
    return NO;
    
    
};

@end
