//
//  ViewController.m
//  LZCoreDataFun
//
//  Created by comst on 15/12/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#define  kLineNameKey @"LZLine"
#define  kLineNumKey  @"lineNumber"
#define  kLineTextKey @"lineText"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    
}

- (void)loadData{
   
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kLineNameKey];
    
    NSArray *result = [context executeFetchRequest:request error:nil];
    if (result == nil) {
        NSLog(@"ftech data error");
        
        return;
    }
    
    for (NSManagedObject *obj in result) {
        int row = [[obj valueForKey:kLineNumKey] intValue];
        NSString *text = [obj valueForKey:kLineTextKey];
        
        UITextField *tf = self.textFields[row];
        tf.text = text;
    }
    
    
}


- (void)resignActive:(NSNotification *)noti{
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    for (int i = 0; i < 4; i ++) {
        UITextField *tf = self.textFields[i];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kLineNameKey];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %d", kLineNumKey, i];
        request.predicate = predicate;
        
        NSArray *result = [context executeFetchRequest:request error:nil];
        
        if (result == nil) {
            NSLog(@"fetch error");
            abort();
        }
        NSManagedObject *obj ;
        if ([result count] == 0) {
            obj = [NSEntityDescription insertNewObjectForEntityForName:kLineNameKey inManagedObjectContext:context];
        }else{
            obj = [result firstObject];
        }
        [obj setValue:@(i) forKey:kLineNumKey];
        [obj setValue:tf.text forKey:kLineTextKey];
        
    }
    
    [appDelegate saveContext];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
