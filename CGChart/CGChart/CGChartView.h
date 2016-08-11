//
//  CGChartView.h
//  CGChart
//
//  Created by Tran Hai Linh on 8/10/16.
//  Copyright © 2016 THL. All rights reserved.
//

#import "HGraph.h"
#define kGraphNotification  @"kGraphNotification"
#define HGraphNotificationTouchUpInsideBar  @"HGraphNotificationTouchUpInsideBar"

IB_DESIGNABLE
@interface CGChartView : UIControl
@property (nonatomic) IBInspectable UIColor*  startColor;
@property (nonatomic) IBInspectable UIColor*  endColor;
#pragma mark Funtions
- (void) addNewGraphInfo:(HGraph* _Nonnull) graphInfo;
- (void) removeGraphInfo:(HGraph* _Nonnull) graphInfo;
- (void) updateChart;

@end
