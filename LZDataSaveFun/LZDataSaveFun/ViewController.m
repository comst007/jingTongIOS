//
//  ViewController.m
//  LZDataSaveFun
//
//  Created by comst on 15/12/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

#define kFileName @"data.plist"
@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

@property (nonatomic, strong) NSMutableArray *contents;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    if ([self fileExist]) {
        [self loadData];
    }
    
}

- (void)loadData{
    
    NSArray *lines = [NSArray arrayWithContentsOfFile:[self filePath]];
    
    for (NSInteger i = 0; i < lines.count; i ++) {
        UITextField *tf = self.textFields[i];
        tf.text = lines[i];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (NSString *)filePath{
    
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filelPath = [basePath stringByAppendingPathComponent:kFileName];
    
    return filelPath;
}


- (void)applicationWillResignActive:(NSNotification *)noti{
    
    [self saveDataByPlist];
}


- (BOOL)fileExist{
    
    return [[NSFileManager defaultManager] fileExistsAtPath:[self filePath]];
    
}

- (void)saveDataByPlist{
    
    if ([self fileExist]) {
        
        [[NSFileManager defaultManager] removeItemAtPath:[self filePath] error:nil];
    }
    self.contents = [NSMutableArray array];
    for (UITextField *tf  in self.textFields) {
        
        [self.contents addObject:tf.text];
        
    }
    
    [self.contents writeToFile:[self filePath] atomically:YES];
    
}



@end
