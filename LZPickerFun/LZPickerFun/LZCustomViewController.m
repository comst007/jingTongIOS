//
//  LZCustomViewController.m
//  LZPickerFun
//
//  Created by comst on 15/12/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZCustomViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface LZCustomViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, assign) SystemSoundID soundID;
@property (nonatomic, assign) SystemSoundID winSoundID;
@end

@implementation LZCustomViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.showLabel.text = @"";
    self.pickerView.userInteractionEnabled = NO;
    
    self.imageArray = @[
                        
                        [UIImage imageNamed:@"apple"],
                        [UIImage imageNamed:@"bar"],
                        [UIImage imageNamed:@"cherry"],
                        [UIImage imageNamed:@"crown"],
                        [UIImage imageNamed:@"lemon"],
                        [UIImage imageNamed:@"seven"]
                        
                        ];
    
    srand((unsigned int)time(NULL));
    
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    self.showLabel.text = @"";
    NSInteger newValue ;
    NSInteger sameCount = 0;
    NSInteger lastValue = -1;
    
    for (NSInteger i = 0; i < 5; i ++) {
        
        newValue = random() % self.imageArray.count;
        
        if (newValue == lastValue) {
            sameCount ++;
        }else{
            sameCount = 1;
        }
        lastValue = newValue;
        
        [self.pickerView selectRow:newValue inComponent:i animated:YES];
    }
    [self playSound];
    if (sameCount >= 3) {
        [self congratulation];
        self.showLabel.text = @"Congratulations!";
    }
    
}

- (void)playSound{
    
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"crunch.wav" withExtension:nil];
    if (self.soundID == 0) {
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(soundURL), &_soundID);
        
    }
    
    AudioServicesPlayAlertSound(self.soundID);
    
}

- (void)congratulation{
    
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"win.wav" withExtension:nil];
    
    if (self.winSoundID == 0) {
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(soundURL), &_winSoundID);
        
    }
    
    AudioServicesPlayAlertSound(self.winSoundID);
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.imageArray.count;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UIImage *image = (UIImage *)self.imageArray[row];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    return imageView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 5;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
@end
