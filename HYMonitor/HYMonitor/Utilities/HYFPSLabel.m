//
//  HYFPSLabel.m
//  HYMonitor
//
//  Created by 贺杨 on 2017/3/2.
//  Copyright © 2017年 He yang. All rights reserved.
//

#import "HYFPSLabel.h"

@interface HYFPSLabel ()
@property (nonatomic, strong)CADisplayLink *displayLink;
@property (nonatomic, assign)NSTimeInterval lastTime;
@property (nonatomic, assign)NSInteger count;
@end

@implementation HYFPSLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:14];
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 1.f;
    }
    return self;
}

-(void)dealloc {
    [_displayLink invalidate];
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    
    if (delta < 1) {
        return;
    }
    
    _lastTime = link.timestamp;
    CGFloat fps = _count / delta;
    _count = 0;
    NSString *text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    self.text = text;
}

@end
