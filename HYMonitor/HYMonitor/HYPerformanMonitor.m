//
//  HYPreformanMonitor.m
//  HYMonitor
//
//  Created by 贺杨 on 2017/3/1.
//  Copyright © 2017年 He yang. All rights reserved.
//

#import "HYPerformanMonitor.h"

@interface HYPerformanMonitor ()

@end

@implementation HYPerformanMonitor {
    CFRunLoopObserverRef _observer;
    dispatch_semaphore_t _semaphore;
    CFRunLoopActivity _activity;
    NSInteger _timeoutCount;
}


static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    HYPerformanMonitor *monitor = (__bridge HYPerformanMonitor *)info;
    monitor ->_activity = activity;
    dispatch_semaphore_t semaphore = monitor ->_semaphore;
    dispatch_semaphore_signal(semaphore);
}

- (instancetype)init {
    if (self = [super init]) {
        _semaphore = dispatch_semaphore_create(0); //停止信号
    }
    return self;
}

- (void)startPerformanceMonitor {
    if (_observer) {
        return;
    }
    
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL,NULL};
    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runLoopObserverCallBack, &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);//必须是kCFRunLoopCommonModes,以保证能全时段监控
    //开线程监控
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (YES) {
            long st = dispatch_semaphore_wait(_semaphore, dispatch_time(DISPATCH_TIME_NOW, 50 * NSEC_PER_MSEC));
            if (st != 0) {
                if (!_observer) {
                    _timeoutCount = 0;
                    _semaphore = 0;
                    _activity = 0;
                    return ;
                }
                if (_activity == kCFRunLoopBeforeSources || _activity == kCFRunLoopAfterWaiting) {
                    if (++_timeoutCount < 5)
                        continue;
                    NSLog(@"\nbegin---\n%@\n---end",@"发生卡顿了" );
                }
            }
            _timeoutCount = 0;
        }
    });
}

- (void)stopPerformanceMonitor {
    if (!_observer) {
        return;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    CFRelease(_observer);
    _observer = NULL;
}

@end
