//
//  LZMainTableViewController.m
//  LZDocumentFun
//
//  Created by comst on 15/12/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMainTableViewController.h"
#import "LZDetailViewController.h"
#import "LZDocumentModel.h"

@interface LZMainTableViewController ()<UITextFieldDelegate>
@property (nonatomic, copy) NSArray *docsArray;
@end

@implementation LZMainTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.docsArray = [self loadData];
    
}


- (IBAction)addDoc:(UIBarButtonItem *)sender {

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"new document" message:@"input a new document name" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *tf = alertVC.textFields[0];
        NSString *docName = [NSString stringWithFormat:@"%@.doc", tf.text];
        [self createDocWithName:docName];
        
        NSLog(@"OK");
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"cancel");
        
    }];
    
    [alertVC addAction:okAction];
    [alertVC addAction:cancelAction];
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
    }];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}


- (NSArray *)loadData{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
     NSArray *result = [fileManager contentsOfDirectoryAtPath:[self docPath] error:nil];
    
    if (result == nil) {
        
        NSLog(@"error");
        
        return nil;
        
    }else{
        
        result = [result sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            NSString *fullPath1 = [[self docPath] stringByAppendingPathComponent:obj1];
            NSString *fullPath2 = [[self docPath] stringByAppendingPathComponent:obj2];
            
            NSFileManager *fileManage = [NSFileManager defaultManager];
            
            NSDictionary *dict1 = [fileManage attributesOfItemAtPath:fullPath1 error:nil];
            NSDictionary *dict2 = [fileManage attributesOfItemAtPath:fullPath2 error:nil];
            
            
            return [dict2[NSFileCreationDate] compare:dict1[NSFileCreationDate]];;
        }];
    }
    
    return result;
}

- (NSString *)docPath{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    return path;
}

- (void)createDocWithName:(NSString *)docName{
    
    NSString *fullName = [[self docPath] stringByAppendingPathComponent:docName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullName]) {
        return;
    }else{
        
        LZDocumentModel *doc = [[LZDocumentModel alloc] initWithFileURL:[NSURL fileURLWithPath:fullName]];
        
        [doc saveToURL:[NSURL fileURLWithPath:fullName] forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"crete file over");
                self.docsArray = [self loadData];
                [self.tableView reloadData];
            }
        }];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"CellToDetail"]) {
        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        LZDetailViewController *detailVC = (LZDetailViewController *)segue.destinationViewController;
        NSString *filePath = [[self docPath] stringByAppendingPathComponent:self.docsArray[indexpath.row]];
        LZDocumentModel *doc = [[LZDocumentModel alloc] initWithFileURL:[NSURL fileURLWithPath:filePath]];
        
        [doc openWithCompletionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"reading file ok");
                detailVC.currentModel = doc;
            }else{
                NSLog(@"reading file faile");
            }
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.docsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell"];
    
    cell.textLabel.text = self.docsArray[indexPath.row];
    
    return cell;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

@end
