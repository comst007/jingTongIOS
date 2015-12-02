//
//  LZClockViewController.m
//  LZPickerFun
//
//  Created by comst on 15/12/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZClockViewController.h"

@interface LZClockViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
@implementation LZClockViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self showDate];
   
    
}

- (IBAction)dateButtonClick:(UIButton *)sender {
    
    [self showDate];
}

- (NSString *)dateString:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    
    return [formatter stringFromDate:date];
}

- (void)showDate{
    
    NSDate *date = [self.datePicker date];
    self.dateLabel.text = [self dateString:date];
}
@end
