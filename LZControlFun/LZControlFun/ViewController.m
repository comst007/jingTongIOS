//
//  ViewController.m
//  LZControlFun
//
//  Created by comst on 15/12/2.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSInteger value = lroundl(sender.value);
    
    self.countLabel.text = [NSString stringWithFormat:@"%@", @(value)];
    
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.leftSwitch.hidden = NO;
        self.rightSwitch.hidden = NO;
        self.actionButton.hidden = YES;
    }else{
        self.leftSwitch.hidden = YES;
        self.rightSwitch.hidden = YES;
        self.actionButton.hidden = NO;
    }
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    
    BOOL value = sender.isOn;
    
    [self.leftSwitch setOn:value animated:YES];
    [self.rightSwitch setOn:value animated:YES];
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"warning" delegate:self cancelButtonTitle:@"Careful" destructiveButtonTitle:@"don't" otherButtonTitles:@"Ok", nil];
    
    [actionSheet showInView:self.view];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
@end
