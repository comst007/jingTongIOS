//
//  ViewController.m
//  LZMotionFun1
//
//  Created by comst on 15/12/10.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *acceleratorLabel;
@property (weak, nonatomic) IBOutlet UILabel *gyroscopeLabel;
@property (nonatomic, strong) CMMotionManager *manager;
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.acceleratorLabel.numberOfLines = 0;
//    self.gyroscopeLabel.numberOfLines = 0;
//    self.queue = [[NSOperationQueue alloc] init];
//    
//    self.manager = [[CMMotionManager alloc] init];
//    self.manager.gyroUpdateInterval = 1 / 10.0;
//    self.manager.accelerometerUpdateInterval = 1 / 10.0;
//     __weak typeof(self) weakSelf = self;
//    [self.manager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
//        NSString *text = [NSString stringWithFormat:@"accelerator: x: %+.2f\ny: %+.2f\nz: %+.2f", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.acceleratorLabel.text = text;
//        });
//        
//    }];
//    
//    [self.manager startGyroUpdatesToQueue:self.queue withHandler:^(CMGyroData *gyroData, NSError *error) {
//        NSString *text = [NSString stringWithFormat:@"gyro: x: %+.2f\ny: %+.2f\nz: %+.2f", gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            weakSelf.gyroscopeLabel.text = text;
//            
//        });
//    }];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"motion begin");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"motion end");
}
@end
