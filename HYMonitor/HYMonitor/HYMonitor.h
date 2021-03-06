//
//  HYMonitor.h
//  HYMonitor
//
//  Created by He yang on 2017/2/27.
//  Copyright © 2017年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYMonitor : NSObject

+ (instancetype)sharedMonitor;

@property (nonatomic, assign)BOOL enabledFPSLabel;

- (void)startMonitor;

- (void)closeMonitor;

@end
