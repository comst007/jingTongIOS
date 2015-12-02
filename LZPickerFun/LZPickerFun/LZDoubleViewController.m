//
//  LZDoubleViewController.m
//  LZPickerFun
//
//  Created by comst on 15/12/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDoubleViewController.h"

@interface LZDoubleViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerview;

@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;

@property (nonatomic, copy) NSArray *firstArray;

@property (nonatomic, copy) NSArray *secondArray;

@end

@implementation LZDoubleViewController


- (void)viewDidLoad{

    [super viewDidLoad];
    self.firstArray = @[@"1", @"2", @"3", @"4", @"5"];
    
     self.secondArray = @[@"one", @"two", @"three", @"four", @"five"];
}


- (IBAction)buttonClick:(UIButton *)sender {
    
    NSInteger firstIndex = [self.pickerview selectedRowInComponent:0];
    NSInteger secondIndex = [self.pickerview selectedRowInComponent:1];
    
    self.selectedLabel.text = [NSString stringWithFormat:@"%@, %@", self.firstArray[firstIndex], self.secondArray[secondIndex]];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return self.firstArray[row];
        
    }else{
        
        return self.secondArray[row];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return self.firstArray.count;
        
    }else{
        
        return self.secondArray.count;
        
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    if (component == 0) {
        return 100;
    }else{
        return 80;
    }
}
@end
