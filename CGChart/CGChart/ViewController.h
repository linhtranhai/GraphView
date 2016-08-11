//
//  ViewController.h
//  CGChart
//
//  Created by Tran Hai Linh on 8/10/16.
//  Copyright © 2016 THL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGChartView.h"
#import "ZPieInfo.h"
#import "ZChartInfo.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet CGChartView *chartView;
@property (weak, nonatomic) IBOutlet CGChartView *pieView;

@end

