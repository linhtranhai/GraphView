//
//  ChartInfo.m
//  CGChart
//
//  Created by Tran Hai Linh on 8/10/16.
//  Copyright © 2016 THL. All rights reserved.
//

#import "ZChartInfo.h"
#import <CoreGraphics/CoreGraphics.h>



@interface ZChartInfo()
{
    double rate;
    int mark;
    
}

@end

@implementation ZChartInfo


#pragma mark init
- (id)init
{
    if ((self = [super init]))
    {
        self.frame = CGRectZero;
        self.textString = @"Mon";
        self.valueUnit = @" $";
    }
    return self;
}

#pragma mark Functions

- (void) drawText:(NSString*)text inRect:(CGRect) rect withAttributed:(NSDictionary*) attr
{
    NSAttributedString * currentText=[[NSAttributedString alloc] initWithString:text attributes: attr];
    [currentText drawWithRect:rect options:NSStringDrawingTruncatesLastVisibleLine context:nil];
    
}

#pragma mark Override from super

// set frame
- (void) setFirstFrame
{
    CGFloat width = self.rect.size.width / self.totalGraphs;
    CGFloat height = self.rect.size.height;
    self.maxSize = CGSizeMake(0, height - paddingTop - paddingBottom);
    
    // set frame
    CGRect frame = self.frame;
    frame.origin.x = 5 + self.index * width;
    frame.origin.y = height - paddingBottom ;
    frame.size.width = width - 10;
    self.frame = frame;
    
    // set rate
    rate = self.value / self.maxValue;
    
    // update mark
    CGFloat valueHeight = self.maxSize.height * rate;
    mark = (valueHeight - self.frame.size.height) / fabs( (valueHeight - self.frame.size.height));
    
}
- (void) updateGraph:(double) interval
{
    // set frame
    CGRect frame = self.frame;
    frame.size.height += interval * 50 * mark;
    self.frame = frame;
};

// validate frame
- (void) validateFrame
{
    CGFloat valueHeight = self.maxSize.height * rate;
    CGRect frame = self.frame;
    if (mark > 0) {
        if (frame.size.height > valueHeight) {
            frame.size.height = valueHeight;
        }
    }else
    {
        if (frame.size.height <= valueHeight) {
            frame.size.height = valueHeight;
        }
    }
    self.frame = frame;
}
// draw backgoround
- (void) drawBackground
{
}
// draw graph
- (void) drawGraph
{
    // Drawing code
    self.bezierPath = [UIBezierPath bezierPath];
    self.bezierPath.lineWidth = 1;
    
    // Set the starting point of the shape.
    [ self.bezierPath moveToPoint:CGPointMake(self.frame.origin.x, self.frame.origin.y)];
    [ self.bezierPath addLineToPoint:CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y )];
    [ self.bezierPath addLineToPoint:CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y - self.frame.size.height)];
    [ self.bezierPath addLineToPoint:CGPointMake(self.frame.origin.x, self.frame.origin.y -  self.frame.size.height)];
    
    // color
    [ self.bezierPath closePath];
    [[UIColor redColor] setFill];
    [ self.bezierPath fill];
    [[UIColor blueColor] setStroke];
    [ self.bezierPath stroke];
    
}

// draw value text
- (void) drawTextValue
{
    
    // attr
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attr = [NSDictionary dictionaryWithObject:style forKey:NSParagraphStyleAttributeName];
    
    // Text value
    CGRect rectTextValue = CGRectMake(self.frame.origin.x - 5, self.frame.origin.y - self.frame.size.height - 5, self.frame.size.width + 10, paddingTop - 5);
    double value = self.frame.size.height * self.maxValue / self.maxSize.height;
    NSString* valueString = [NSString stringWithFormat:@"%.1f%@",value,self.valueUnit];
    [self drawText:valueString inRect:rectTextValue withAttributed:attr];
}

// draw name text
- (void) drawTextName
{
    // attr
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attr = [NSDictionary dictionaryWithObject:style forKey:NSParagraphStyleAttributeName];
    
    // Text
    CGRect rectText = CGRectMake(self.frame.origin.x - 5, self.frame.origin.y + paddingBottom - 5, self.frame.size.width + 10, paddingBottom - 5);
    [self drawText:self.textString inRect:rectText withAttributed:attr];
}



@end
