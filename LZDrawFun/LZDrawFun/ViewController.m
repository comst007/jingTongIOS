//
//  ViewController.m
//  LZDrawFun
//
//  Created by comst on 15/12/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZDrawView.h"



@interface ViewController ()<UIToolbarDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegment;
@property (weak, nonatomic) IBOutlet UIToolbar *shapeSelect;
@property (weak, nonatomic) IBOutlet LZDrawView *drawView;
@property (nonatomic, assign) shapeType type;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self colorSelected:self.colorSegment];
    [self lineShapeSelect:nil];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)colorSelected:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    self.drawView.color = [self colorForSelectIndex:index];
    
}

- (UIColor *)colorForSelectIndex:(NSInteger)index{
    switch (index) {
        case 0:
            return [UIColor redColor];
            break;
        case 1:
            return [UIColor greenColor];
            break;
        case 2:
            
            return [UIColor blueColor];
            break;
        case 3:
            
            return [UIColor colorWithRed: (CGFloat)arc4random() / RAND_MAX green:(CGFloat)arc4random() / RAND_MAX blue:(CGFloat)arc4random() / RAND_MAX alpha:1];
            break;
        default:
            break;
    }
    return nil;
}

- (IBAction)lineShapeSelect:(UIBarButtonItem *)sender {
    self.type = shapeTypeLine;
}

- (IBAction)rectangleShapeSelect:(UIBarButtonItem *)sender {
    self.type = shapeTypeRectangle;
}

- (IBAction)ovalShapeSelected:(UIBarButtonItem *)sender {
    self.type = shapeTypeOval;
}

- (IBAction)imageShapSlected:(id)sender {
    self.type = shapeTypeImage;
}

- (void)setType:(shapeType)type{
    _type = type;
    self.drawView.type = type;
}
@end
