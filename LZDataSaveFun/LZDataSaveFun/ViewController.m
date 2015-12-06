//
//  ViewController.m
//  LZDataSaveFun
//
//  Created by comst on 15/12/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZFileContent.h"
#import <sqlite3.h>
#define kFileName @"data.sqlite"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, assign) sqlite3  *db;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    if ([self fileExist]) {
        [self loadSqliteData];
    }
    
}

- (void)loadPlistData{
    
    NSArray *lines = [NSArray arrayWithContentsOfFile:[self filePath]];
    
    for (NSInteger i = 0; i < lines.count; i ++) {
        UITextField *tf = self.textFields[i];
        tf.text = lines[i];
    }
    
}

- (void)loadSqliteData{
    
    sqlite3 *db ;
    
    if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK) {
        NSLog(@"open db failed");
        return ;
    }
    
    NSString *querySQL = @"SELECT ROW, FIELD_DATA FROM FIELDS ORDER BY ROW";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, [querySQL UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            int row = sqlite3_column_int(stmt, 0);
            char* ctext = (char*)sqlite3_column_text(stmt, 1);
            
            UITextField *tf = self.textFields[row];
            
            tf.text = [NSString stringWithUTF8String:ctext];
            
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(db);

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
    
    [self saveBySqlite3];
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

- (BOOL)sqlitePrepare{
    
    if (![self fileExist]) {
        sqlite3 *db ;
        
        if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK) {
            NSLog(@"create db failed");
            return NO;
        }
        
        NSString *createTableSQL = @"CREATE TABLE IF NOT EXISTS FIELDS(ROW INTEGER PRIMERY KEY, FIELD_DATA TEXT);";
        
        char *errMSG = NULL;
        
        if (sqlite3_exec(db, [createTableSQL UTF8String], NULL, NULL, &errMSG) != SQLITE_OK) {
            sqlite3_close(db);
            NSLog(@"create table error %s", errMSG);
            return NO;
        }
        self.db = db;
    }
    return YES;
}

- (void)saveBySqlite3{
    
    if (![self sqlitePrepare]) {
        return;
    }
    for (int i = 0; i < 4; i ++) {
        UITextField *tf = self.textFields[i];
        char *updateSQL = "INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA) VALUES(?, ?);";
        char *errMSG = NULL;
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(self.db, updateSQL, -1, &stmt, NULL) == SQLITE_OK) {
            sqlite3_bind_int(stmt, 1, i);
            sqlite3_bind_text(stmt, 2, [tf.text UTF8String], -1, NULL);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSLog(@"update table fail");
            sqlite3_finalize(stmt);
            sqlite3_close(self.db);
            return ;
            
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(self.db);
    
    
}
@end
