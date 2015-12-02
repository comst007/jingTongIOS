//
//  LZDependencyViewController.m
//  LZPickerFun
//
//  Created by comst on 15/12/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDependencyViewController.h"

@interface LZDependencyViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;
@property (nonatomic, copy) NSDictionary *dic;
@property (nonatomic, copy) NSArray *secondArray;
@property (nonatomic, copy) NSArray *firstArray;

@end

@implementation LZDependencyViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self loadData];
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    NSInteger firstIndex = [self.pickerView selectedRowInComponent:0];
    NSInteger secondIndex = [self.pickerView selectedRowInComponent:1];
    
    self.selectedLabel.text = [NSString stringWithFormat:@"%@, %@", self.firstArray[firstIndex], self.secondArray[secondIndex]];
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    if (component == 0) {
        return 100;
    }else{
        return 150;
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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.firstArray[row];
    }else{
        return self.secondArray[row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        
        self.secondArray = self.dic[self.firstArray[row]];
        
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

- (void)loadData{
    
   NSString *plistPath =  [[NSBundle mainBundle] pathForResource:@"statedictionary.plist" ofType:nil];
   
    self.dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    self.firstArray = [[self.dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 compare:(NSString *)obj2];
    }];
    
    self.secondArray = self.dic[self.firstArray[0]];
}
@end
