//
//  LZMotionView.m
//  LZMotinBall
//
//  Created by comst on 15/12/10.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMotionView.h"

@interface LZMotionView ()

@property (nonatomic, assign) CGPoint prePoint;
@property (nonatomic, assign) CGPoint curPoint;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGFloat xVelocity;
@property (nonatomic, assign) CGFloat yVelocity;
@property (nonatomic, strong) NSDate *lastDate;

@end
@implementation LZMotionView

- (void)commonInit{
    self.image = [UIImage imageNamed:@"ball"];
    self.curPoint = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    self.xVelocity = 1;
    self.yVelocity = 1;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect{
    [self.image drawAtPoint:self.curPoint];
}

- (void)setCurPoint:(CGPoint)curPoint{
    _curPoint = curPoint;
    CGSize ballSize = self.image.size;
    CGSize boundSize = self.bounds.size;
    
    if (curPoint.x <= 0) {
        _curPoint.x = 0;
        self.xVelocity = - (self.xVelocity * 0.5);
    }else if (curPoint.y <= 0){
        _curPoint.y = 0;
        self.yVelocity = - self.yVelocity * 0.5;
    }else if (curPoint.x + ballSize.width >= boundSize.width){
        _curPoint.x = boundSize.width - ballSize.width;
        self.xVelocity = - self.xVelocity * 0.5;
    }else if (curPoint.y + ballSize.height >= boundSize.height){
        _curPoint.y = boundSize.height - ballSize.height;
        self.yVelocity = - 0.5 * self.yVelocity;
    }
    
    [self setNeedsDisplay];
}

- (void)setAccelerateData:(CMAccelerometerData *)accelerateData{
    
    
    _accelerateData = accelerateData;
    if (self.lastDate == nil) {
        self.lastDate = [[NSDate alloc] init];
        return;
    }
    NSTimeInterval times = [[NSDate date] timeIntervalSinceDate:self.lastDate];
    //NSLog(@"interval: %li", times);
    self.xVelocity = self.xVelocity + times * accelerateData.acceleration.x;
    self.yVelocity = self.yVelocity - times * accelerateData.acceleration.y;
    
    CGFloat xDistance = self.xVelocity * times * 500;
    CGFloat yDistance = self.yVelocity * times * 500;
    
    self.curPoint = CGPointMake(self.curPoint.x + xDistance, self.curPoint.y + yDistance);
    
    self.lastDate = [[NSDate alloc] init];
    
    
    
}

@end
