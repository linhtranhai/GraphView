//
//  ViewController.m
//  CGChart
//
//  Created by Tran Hai Linh on 8/10/16.
//  Copyright © 2016 THL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnChange;
@property (nonatomic)  NSMutableArray*  listChartInfo;
@property (nonatomic)  NSMutableArray*  listPieInfo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // bar value
    self.listChartInfo = [[NSMutableArray alloc] init];
    self.listPieInfo = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotificationTouchOnGraph:) name:HGraphNotificationTouchUpInsideBar object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HGraphNotificationTouchUpInsideBar object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionTouchUpBtnUpdate:(id)sender {
    
    
    if (self.btnChange.selected) {
        
        
        for (ZPieInfo* chartInfo in self.listPieInfo) {
            NSInteger randomNumber = arc4random() % 100;
            chartInfo.value = randomNumber;
        }
        
        //
        [self rePies];
        
        // update
        [self.pieView updateChart];
    }else
    {
        
        for (ZChartInfo* chartInfo in self.listChartInfo) {
            NSInteger randomNumber = arc4random() % (int)chartInfo.maxValue;
            chartInfo.value = randomNumber;
            NSLog(@"randomNumber : %ld",(long)randomNumber);
        }
        // update
        [self.chartView updateChart];
        
    }
    
}

- (void) rePies
{
    double freValue = 0;
    for (ZPieInfo* chartInfo in self.listPieInfo) {
        chartInfo.prePieValue = freValue;
        freValue += chartInfo.value;
    }
    
    //
    for (ZPieInfo* chartInfo in self.listPieInfo) {
        chartInfo.maxValue = freValue;
    }
    
}

- (IBAction)Remove:(id)sender {
    if (self.btnChange.selected) {
        // update
        [self.pieView removeGraphInfo:self.listPieInfo.lastObject];
        [self.listPieInfo removeLastObject];
        
        //
        [self rePies];
        
        // update
        [self.pieView updateChart];
    }else
    {
        
        // update
        [self.chartView removeGraphInfo:self.listChartInfo.lastObject];
        [self.listChartInfo removeLastObject];
        // update
        [self.chartView updateChart];
    }
    
}
- (IBAction)actionTouchUpBtnCreate:(id)sender {
    if (self.btnChange.selected) {
        
        //  create new value
        NSInteger randomNumber = arc4random() % 100;
        ZPieInfo* chartInfo = [[ZPieInfo alloc] init];
        chartInfo.value = randomNumber;
        [self.pieView addNewGraphInfo:chartInfo];
        [self.listPieInfo addObject:chartInfo];
        
        //
        [self rePies];
        
        // update
        [self.pieView updateChart];
    }else
    {
        ZChartInfo* chartInfo = [[ZChartInfo alloc] init];
        chartInfo.maxValue = 800;
        chartInfo.value = 100;
        [self.chartView addNewGraphInfo:chartInfo];
        [self.listChartInfo addObject:chartInfo];
        // update
        [self.chartView updateChart];
    }
    
    
    
}

- (IBAction)change:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        //hide Graph
        [UIView transitionFromView:self.chartView toView:self.pieView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews completion:nil];
        
    } else {
        
        //show Graph
        [UIView transitionFromView:self.pieView toView:self.chartView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews completion:nil];
    }
    
}

- (void) didReceiveNotificationTouchOnGraph:(NSNotification*)notification
{
    HGraph* nofity = (HGraph*)notification.userInfo[kGraphNotification];
    if ([nofity isKindOfClass:[ZChartInfo class]]) {
        self.btnChange.selected = NO;
        [self change:self.btnChange];
    }else{
//        self.btnChange.selected = YES;
//        [self change:self.btnChange];
    }

}
@end
