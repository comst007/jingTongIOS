//
//  ViewController.m
//  LZMotinBall
//
//  Created by comst on 15/12/10.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "LZMotionView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet LZMotionView *ballView;
@property (nonatomic, strong) CMMotionManager *manager;
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.queue = [[NSOperationQueue alloc] init];
    self.manager = [[CMMotionManager alloc] init];
    self.manager.accelerometerUpdateInterval = 1 / 60.0;
     __weak typeof(self) weakSelf = self;
    [self.manager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.ballView.accelerateData = accelerometerData ;
        });
    }];
    
}


@end
