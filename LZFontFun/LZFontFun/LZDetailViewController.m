//
//  LZDetailViewController.m
//  LZFontFun
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDetailViewController.h"
#import "LZFavoriteList.h"
@interface LZDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UISwitch *favoriteSwitch;
@property (weak, nonatomic) IBOutlet UISlider *fontSIzeSlider;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLabel;

@end

@implementation LZDetailViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.favoriteSwitch setOn:self.isFavorite];
    
    self.navigationItem.title = self.fontName;
    
    self.detailLabel.font = [UIFont fontWithName:self.fontName size:10];
    
    self.detailLabel.text = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
}

- (IBAction)switchChanged:(UISwitch *)sender {
    
    if (sender.isOn == YES) {
        [[LZFavoriteList sharedList] addNewItem:self.fontName];
    }else{
        NSLog(@"%@", [LZFavoriteList sharedList].favoriteList);
        NSInteger index = [[LZFavoriteList sharedList].favoriteList indexOfObject:self.fontName];
        [[LZFavoriteList sharedList] deleteItemAtIndex:index];
    }
}

- (IBAction)fontsizeChanged:(UISlider *)sender {
    
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%@", @(self.fontSIzeSlider.value)];
    self.detailLabel.font = [UIFont fontWithName:self.fontName size:self.fontSIzeSlider.value];
    
}

@end
