//
//  HYMonitor.m
//  HYMonitor
//
//  Created by He yang on 2017/2/27.
//  Copyright © 2017年 He yang. All rights reserved.
//

#import "HYMonitor.h"
#import "HYNetworkMonitor.h"
#import "HYPerformanMonitor.h"
#import "HYUserBehaviorMonitor.h"
#import "HYFPSLabel.h"
@interface HYMonitor ()

@property (nonatomic, strong) HYNetworkMonitor *networkMonitor;
@property (nonatomic, strong) HYPerformanMonitor *performanceMonitor;
@property (nonatomic, strong)HYUserBehaviorMonitor *userBehaviorMonitor;

@end

@implementation HYMonitor

+ (instancetype)sharedMonitor {
    static HYMonitor *monitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[HYMonitor alloc] init];
    });
    return monitor;
}

- (instancetype)init {
    if (self = [super init]) {
        _networkMonitor = [[HYNetworkMonitor alloc] init];
        _performanceMonitor = [[HYPerformanMonitor alloc] init];
    }
    return self;
}

- (void)startMonitor {
    [_performanceMonitor startPerformanceMonitor];
}

- (void)closeMonitor {
    
}

- (void)setEnabledFPSLabel:(BOOL)enabledFPSLabel {
    _enabledFPSLabel = enabledFPSLabel;
    if (_enabledFPSLabel) {
        HYFPSLabel *fpsLabel = [[HYFPSLabel alloc] initWithFrame:CGRectMake(0, 70, 54, 20)];
        [[[UIApplication sharedApplication].delegate window] addSubview:fpsLabel];
        //假如是didFinishLaunching中设置该属性，会导致添加的fpsLabel被Controller所持有的view覆盖，所以需要延迟操作
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[[UIApplication sharedApplication].delegate window]  bringSubviewToFront:fpsLabel];
        });
    }
}

@end
