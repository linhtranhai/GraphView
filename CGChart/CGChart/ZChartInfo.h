//
//  ZChartInfo.h
//  CGChart
//
//  Created by Tran Hai Linh on 8/10/16.
//  Copyright © 2016 THL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGraph.h"


#define paddingTop 10
#define paddingBottom 20

@interface ZChartInfo : HGraph

@property (nonatomic) int chartId;
@property (nonatomic) NSString* textString;
@property (nonatomic) NSString* valueUnit;

#pragma mark Funtions

@end
