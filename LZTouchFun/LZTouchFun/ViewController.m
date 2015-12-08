//
//  ViewController.m
//  LZTouchFun
//
//  Created by comst on 15/12/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
const CGFloat kMinMoveDistance = 40;
const CGFloat kMaxDeltdistance = 5;

@interface ViewController ()
@property (nonatomic, assign) CGPoint startPoint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) CGFloat preScale;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self addSwipeGesture];
    //[self addTapGesture];
    self.preScale = 1;
    [self addpinchGesture];
}


- (void)addpinchGesture{
   
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureReconized:)];
    
    [self.view addGestureRecognizer:pinchGesture];
}

- (void)pinchGestureReconized:(UIPinchGestureRecognizer *)gesture{
    
    self.imageView.transform = CGAffineTransformMakeScale(gesture.scale * self.preScale, gesture.scale * self.preScale);
    
    if ([gesture state] == UIGestureRecognizerStateEnded) {
        
        self.preScale = self.preScale * gesture.scale;
    }
}

- (void)addTapGesture{
   
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    tap1.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    tap2.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    tap3.numberOfTapsRequired = 3;
    
    [self.view addGestureRecognizer:tap3];
    [tap1 requireGestureRecognizerToFail:tap2];
    [tap2 requireGestureRecognizerToFail:tap3];
    
}

- (void)tapGestureRecognized:(UITapGestureRecognizer *)gesture{
    
    NSLog(@"tap , tapCount: %li", gesture.numberOfTapsRequired);
}




- (void)addSwipeGesture{
    for (NSInteger i = 1; i <= 5; i ++) {
        
        UISwipeGestureRecognizer *verticalGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(verticalGestureRecgonized:)];
        verticalGesture.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
        verticalGesture.numberOfTouchesRequired = i;
        UISwipeGestureRecognizer *horizontalGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalGestureRecognized:)];
        horizontalGesture.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
        horizontalGesture.numberOfTouchesRequired = i;
        [self.view addGestureRecognizer:verticalGesture];
        [self.view addGestureRecognizer:horizontalGesture];
        
        
    }
}

- (void)horizontalGestureRecognized:(UISwipeGestureRecognizer *)gesture{
    
    NSLog(@"horizontal swipe, touches: %li", gesture.numberOfTouches);
}

- (void)verticalGestureRecgonized:(UISwipeGestureRecognizer *)gesture{
    
    NSLog(@"vertical swipe, touches: %li", gesture.numberOfTouches);
}

//
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//    UITouch *touch = [touches anyObject];
//    
//    self.startPoint = [touch locationInView:self.view];
//    
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//    UITouch *touch = [touches anyObject];
//    CGPoint currentPoint = [touch locationInView:self.view];
//    
//    CGFloat distanceH = fabs(self.startPoint.x - currentPoint.x);
//    CGFloat distanceV = fabs(self.startPoint.y - currentPoint.y);
//    
//    if (distanceH >= kMinMoveDistance && distanceV <= kMaxDeltdistance) {
//        NSLog(@"swipe horization");
//    }else if (distanceV >= kMinMoveDistance && distanceH <= kMaxDeltdistance){
//        NSLog(@"swipe vertical");
//    }
//}
@end
