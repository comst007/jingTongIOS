//
//  ViewController.m
//  LZDataSaveFun
//
//  Created by comst on 15/12/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZFileContent.h"
#define kFileName @"data.archive"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

@property (nonatomic, strong) NSMutableArray *contents;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    if ([self fileExist]) {
        [self loadArchiveData];
    }
    
}

- (void)loadPlistData{
    
    NSArray *lines = [NSArray arrayWithContentsOfFile:[self filePath]];
    
    for (NSInteger i = 0; i < lines.count; i ++) {
        UITextField *tf = self.textFields[i];
        tf.text = lines[i];
    }
    
}

- (void)loadArchiveData{
    NSData *readData = [NSData dataWithContentsOfFile:[self filePath]];
    
    NSKeyedUnarchiver *unchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:readData];
    
    LZFileContent *fileContent = [unchiver decodeObjectForKey:@"fileContent"];
    
    for (NSInteger i = 0; i < fileContent.content.count; i ++) {
        UITextField *tf = self.textFields[i];
        tf.text = fileContent.content[i];
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
    
    [self saveDataByArchive];
}


- (BOOL)fileExist{
    
    return [[NSFileManager defaultManager] fileExistsAtPath:[self filePath]];
    
}

- (void)prePareBeforeSave{
    
    if ([self fileExist]) {
        
        [[NSFileManager defaultManager] removeItemAtPath:[self filePath] error:nil];
        
    }
    self.contents = [NSMutableArray array];
    for (UITextField *tf  in self.textFields) {
        
        [self.contents addObject:tf.text];
        
    }
    
}

- (void)saveDataByPlist{
    
    [self prePareBeforeSave];
    
    [self.contents writeToFile:[self filePath] atomically:YES];
    
}

- (void)saveDataByArchive{
    
    [self prePareBeforeSave];
    
    LZFileContent *fileContent = [[LZFileContent alloc] init];
    fileContent.content = self.contents;
    
    NSMutableData *saveData = [NSMutableData data];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:saveData];
    
    [archiver encodeObject:fileContent forKey:@"fileContent"];
    
    [archiver finishEncoding];
    
    [saveData writeToFile:[self filePath] atomically:YES];
    
}

@end
