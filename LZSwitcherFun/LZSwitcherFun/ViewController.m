//
//  ViewController.m
//  LZSwitcherFun
//
//  Created by comst on 15/12/2.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZOrangeViewController.h"
#import "LZBlueViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIViewController *blueVC;
@property (nonatomic, strong) UIViewController *orangeVC;
@property (nonatomic, assign) BOOL isBlueView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.isBlueView = YES;
    [self.view insertSubview:self.blueVC.view atIndex:0];
}



- (IBAction)buttonClick:(UIButton *)sender {
    
    self.isBlueView = !self.isBlueView;
    
    [UIView transitionWithView:self.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
        
        if (self.isBlueView == YES) {
            [self.blueVC.view removeFromSuperview];
            [self.view insertSubview:self.orangeVC.view atIndex:0];
        }else{
            [self.orangeVC.view removeFromSuperview];
            [self.view insertSubview:self.blueVC.view atIndex:0];
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

- (UIViewController *)blueVC{
    if (!_blueVC) {
        _blueVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BlueVC"];
    }
    return _blueVC;
}

- (UIViewController *)orangeVC{
    if (!_orangeVC) {
        _orangeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrangeVC"];
    }
    return _orangeVC;
}
@end
