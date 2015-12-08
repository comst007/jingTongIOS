//
//  ViewController.m
//  LZStateFun
//
//  Created by comst on 15/12/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (nonatomic, assign) BOOL animated;

@property (nonatomic, assign) CGAffineTransform transform;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerObserver];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewdidLoad");
    self.transform = CGAffineTransformIdentity;
    self.animated = YES;
    [self loadData];
}

- (void)loadData{
    [self loadImage];
    [self loadSegmentData];
}

- (void)clearImageData{
    self.iconImageView.image = nil;
}

- (void)saveSegmentData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:self.segment.selectedSegmentIndex forKey:@"selectIndex"];
}

- (void)loadSegmentData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.segment.selectedSegmentIndex = [defaults integerForKey:@"selectIndex"];
    
}

- (void)loadImage{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"smiley.png" ofType:nil];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    self.iconImageView.image = image;
}

- (void)registerObserver{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(appDidBecomActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [center addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [center addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [center addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}


- (void)rotateUp{
    
    
    [UIView animateWithDuration:1.75 animations:^{
        
        self.textLabel.transform = CGAffineTransformRotate(self.textLabel.transform, M_PI);
        
    } completion:^(BOOL finished) {
        [self rotateDown];
    }];
}

- (void)rotateDown{
    
    if (self.animated == NO) {
        return;
    }
    
    [UIView animateWithDuration:1.75 animations:^{
        
        self.textLabel.transform = CGAffineTransformRotate(self.textLabel.transform, M_PI);
        
    } completion:^(BOOL finished) {
        [self rotateUp];
    }];
}



- (void)appDidBecomActive:(NSNotification *)noti{
    self.animated = YES;
    self.textLabel.transform = self.transform;
    [self rotateDown];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)appWillResignActive:(NSNotification *)noti{
    self.transform = self.textLabel.transform;
    self.animated = NO;
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)appDidEnterBackground:(NSNotification *)noti{
    
    __block UIBackgroundTaskIdentifier bkID;
    
    UIApplication *app = [UIApplication sharedApplication];
    
    bkID = [app beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"time expiration");
        [app endBackgroundTask:bkID];
    }];
    
    if (bkID == UIBackgroundTaskInvalid) {
        NSLog(@"fail to enter bacground");
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self clearImageData];
        [NSThread sleepForTimeInterval:60];
        [self saveSegmentData];
        NSLog(@"%@", NSStringFromSelector(_cmd));
        
        [app endBackgroundTask:bkID];
    });
}

- (void)appWillEnterForeground:(NSNotification *)noti{
    [self loadData];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
