//
//  CGChartView.m
//  CGChart
//
//  Created by Tran Hai Linh on 8/10/16.
//  Copyright © 2016 THL. All rights reserved.
//

#import "CGChartView.h"



@interface CGChartView()
{
    BOOL firstRunOnDislayLink;
    CFTimeInterval previousTimestamp;
}
@property (nonatomic)  NSMutableArray* _Nonnull listGraphInfo;
@property (nonatomic)  CADisplayLink * displayLink ;
@end


@implementation CGChartView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initView];
    }
    return self;
}

#pragma mark - Init
- (void) initView
{
    self.listGraphInfo = [[NSMutableArray alloc] init];
    
}

- (void)dealloc
{
    NSLog(@"dealloc");
    [self stopDisplayLink];
}
// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect {
    
    
    //2 - get the current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace =  CGColorSpaceCreateDeviceRGB();
    UIColor *startColor = [UIColor clearColor];
    if (self.startColor) {
        startColor = self.startColor;
    }
    UIColor *endColor = [UIColor clearColor];
    if (self.endColor) {
        endColor = self.endColor;
    }
    
    
    CGFloat *startColorComponents =
    (CGFloat *)CGColorGetComponents([startColor CGColor]);
    
    CGFloat *endColorComponents =
    (CGFloat *)CGColorGetComponents([endColor CGColor]);
    
    CGFloat colorComponents[8] = {
        /* Four components of the orange color (RGBA) */
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3], /* First color = orange */
        /* Four components of the blue color (RGBA) */
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3], /* Second color = blue */
    };
    CGFloat colorLocations[3] = {0.0, 0.5, 1.0};
    //    CGFloat components[12] = {1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, colorLocations, 3);
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    
    // draw graph
    for (HGraph*  graphInfo in self.listGraphInfo) {
        
        [graphInfo draw];
    }
}

#pragma mark - Functions
- (void) addNewGraphInfo:(HGraph* _Nonnull) graphInfo
{
    // add to list
    [self.listGraphInfo addObject:graphInfo];
    
}

- (void) removeGraphInfo:(HGraph* _Nonnull) graphInfo
{
    [self.listGraphInfo removeObject:graphInfo];
};

-(void) updateChart
{
    // update frame
    [self updateGraphFrame];
    
    // start
    [self startDisplayLink];
    
}

-(void) updateGraphFrame
{
    int count = (int)self.listGraphInfo.count;
    for (int i = 0; i < count; i++) {
        // get chart infos
        HGraph* graphInfo = self.listGraphInfo[i];
        graphInfo.index = i;
        graphInfo.totalGraphs = count;
        graphInfo.rect = self.bounds;
        
        // set frame
        [graphInfo setFirstFrame];
    }
    
}


-(void) updateView:(double) interval
{
    for (HGraph* graphInfo in self.listGraphInfo) {
        [graphInfo updateGraph:interval];
    }
    
    [self setNeedsDisplay];
};

#pragma mark CADisplayLink
- (void) startDisplayLink {
    
    // stop and create new CADisplayLink
    [self stopDisplayLink];
    
    // create new CDDisplay links
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(actionRunOnDisplayLink:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void) stopDisplayLink {
    [self.displayLink invalidate];
    self.displayLink = nil;
    firstRunOnDislayLink = YES;
}

- (void) actionRunOnDisplayLink:(CADisplayLink *)displayLink
{
    CFTimeInterval currentTimestamp = [displayLink timestamp];
    
    // calculate delta time
    CFTimeInterval interval;
    if(firstRunOnDislayLink) {
        firstRunOnDislayLink = NO;
        interval = 0.0;
    } else {
        interval = currentTimestamp - previousTimestamp;
    }
    
    // set previous
    previousTimestamp = currentTimestamp;
    
    // update view with interval
    [self updateView:interval];
}

#pragma mark UITouch
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    //           NSLog(@"endTrackingWithTouch: %f, %f ",touchPoint.x,touchPoint.y);
    for (HGraph* graphInfo in self.listGraphInfo) {
        if ([graphInfo containtPoint:touchPoint])
            //        if(CGRectContainsPoint(chartInfo.originFrame, touchPoint))
        {
            graphInfo.highlighted = YES;
            [self setNeedsDisplay];
        }
    }
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    for (HGraph* graphInfo in self.listGraphInfo) {
        // reset highlighted
        if (graphInfo.highlighted) {
            graphInfo.highlighted = NO;
            [self setNeedsDisplay];
        }
        
        // touch in inside
        if ([graphInfo containtPoint:touchPoint])
        {
            NSLog(@"Touch at index :%d",[graphInfo index]);
            // post Notification
            [[NSNotificationCenter defaultCenter] postNotificationName:HGraphNotificationTouchUpInsideBar object:nil userInfo:@{kGraphNotification: graphInfo}];
            break;
        }
    }
}


@end
