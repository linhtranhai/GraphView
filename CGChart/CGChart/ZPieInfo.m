//
//  ZPieInfo.m
//  CGChart
//
//  Created by Tran Hai Linh on 8/11/16.
//  Copyright © 2016 THL. All rights reserved.
//

#import "ZPieInfo.h"

#define pi  3.14

@interface ZPieInfo()
{
    
}

@end

@implementation ZPieInfo



#pragma mark Override from super

// set frame
- (void) setFirstFrame
{
    CGFloat width = self.rect.size.width;
    CGFloat height = self.rect.size.height;
    
    self.maxSize = CGSizeMake(0, self.maxValue);
    
    // set frame
    CGRect frame = self.frame;
    frame.size.width = width / 2 - 20;
    frame.origin.x = width / 2;
    frame.origin.y = height / 2;
    frame.size.height = self.value + self.prePieValue;
    self.frame = frame;
}

- (void) updateGraph:(double) interval
{

};

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
    CGContextRef context = UIGraphicsGetCurrentContext ();
    CGContextSaveGState(context);
    
    CGPoint center = CGPointMake(self.frame.origin.x,self.frame.origin.y);
    CGFloat radius = self.frame.size.width;
    CGFloat startAngle = 2 * pi * self.prePieValue / self.maxValue;
    CGFloat endAngle  = 2 * pi * (self.value + self.prePieValue) / self.maxValue;
    self.bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [self.bezierPath addLineToPoint:center];
    self.bezierPath.lineWidth = 1;
    [self.bezierPath closePath];
    if (self.index % 3 == 0) {
        [[UIColor redColor] setFill];
    }
    if (self.index % 3 == 1) {
        [[UIColor yellowColor] setFill];
    }
    if (self.index % 3 == 2) {
        [[UIColor blueColor] setFill];
    }
    
    
    [self.bezierPath fill];
    
    [self.bezierPath addClip];
    CGContextRestoreGState(context);
}

// draw value text
- (void) drawTextValue
{

}

// draw name text
- (void) drawTextName
{

}



@end
