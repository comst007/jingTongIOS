//
//  ViewController.m
//  ButtonFun
//
//  Created by comst on 15/12/2.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    NSString *text = [sender titleForState:UIControlStateNormal];
    
    text = [NSString stringWithFormat:@"%@ button clicked", text];
    self.titleLabel.attributedText = [self transformAttributeString:text];
    
}

- (NSAttributedString *)transformAttributeString:(NSString *)string{
    
    NSMutableAttributedString *attributeStringM = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSString *targetString = [[string componentsSeparatedByString:@" "] firstObject];
    
    NSRange range = [string rangeOfString:targetString];
    
    NSDictionary *attributeDic = @{NSFontAttributeName :[UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName:[UIColor redColor]};
    
    [attributeStringM addAttributes:attributeDic range:range];
    
    return attributeStringM;
    
}


@end
