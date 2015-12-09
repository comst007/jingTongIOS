//
//  ViewController.m
//  LZMotionFun2
//
//  Created by comst on 15/12/10.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSURL *soundURL;
@property (nonatomic, assign) BOOL isBroken;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *brokenImage;
@property (nonatomic, strong) AVAudioPlayer *soundPlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.normalImage = [UIImage imageNamed:@"home"];
    self.brokenImage = [UIImage imageNamed:@"homebroken"];
    
    self.soundURL = [[NSBundle mainBundle] URLForResource:@"glass" withExtension:@"wav"];
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.soundURL error:nil];
    self.isBroken = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.isBroken = NO;
    self.imageView.image = self.normalImage;
}



- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (self.isBroken == NO && motion == UIEventSubtypeMotionShake) {
        self.isBroken = YES;
        [self.soundPlayer play];
        self.imageView.image = self.brokenImage;
    }
}



@end
