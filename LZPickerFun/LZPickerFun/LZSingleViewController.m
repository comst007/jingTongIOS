//
//  LZSingleViewController.m
//  LZPickerFun
//
//  Created by comst on 15/12/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZSingleViewController.h"

@interface LZSingleViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;
@property (nonatomic, copy) NSArray *list;
@end

@implementation LZSingleViewController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.list = @[@"one",@"two",@"lala",@"three",@"four"];
    
    
}

- (IBAction)buttonClick:(UIButton *)sender {
     NSInteger index =  [self.pickerView selectedRowInComponent:0];
    self.selectedLabel.text = self.list[index];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.list.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.list[row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
@end
