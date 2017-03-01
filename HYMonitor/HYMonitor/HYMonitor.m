//
//  HYMonitor.m
//  HYMonitor
//
//  Created by He yang on 2017/2/27.
//  Copyright © 2017年 He yang. All rights reserved.
//

#import "HYMonitor.h"
#import "HYNetworkMonitor.h"
#import "HYPreformanMonitor.h"
#import "HYUserBehaviorMonitor.h"
@interface HYMonitor ()

@property (nonatomic, strong) HYNetworkMonitor *networkMonitor;
@property (nonatomic, strong) HYPreformanMonitor *performanceMonitor;
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
    }
    return self;
}

- (void)startMonitor {
    
}

- (void)closeMonitor {
    
}

@end
