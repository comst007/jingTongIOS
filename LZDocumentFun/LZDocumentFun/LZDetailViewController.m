//
//  LZDetailViewController.m
//  LZDocumentFun
//
//  Created by comst on 15/12/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDetailViewController.h"


@interface LZDetailViewController ()

@property (weak, nonatomic) IBOutlet LZDocumentView *docView;

@end

@implementation LZDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCurrentModel:(LZDocumentModel *)currentModel{
    _currentModel = currentModel;
    self.docView.currentModel = currentModel;
    [self.view setNeedsDisplay];
    [self.docView setNeedsDisplay];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.currentModel closeWithCompletionHandler:nil];
}

@end
