//
//  LZDrawView.m
//  LZDrawFun
//
//  Created by comst on 15/12/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDrawView.h"


@interface LZDrawView ()

@property (nonatomic, assign) CGPoint startPosition;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic, strong) UIImage *image;

@end

@implementation LZDrawView

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect shapeRect ;
    CGSize phoneSize ;
    switch (self.type) {
            
        case shapeTypeLine:
            
            [self.color setStroke];
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextSetLineWidth(context, 3);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            CGContextMoveToPoint(context, self.startPosition.x, self.startPosition.y);
            for (int i = 1; i < self.lines.count; i ++) {
                CGPoint point = [self.lines[i] CGPointValue];
                CGContextAddLineToPoint(context, point.x, point.y);
            }
            CGContextStrokePath(context);
            break;
            
        case shapeTypeRectangle:
            CGContextSetFillColorWithColor(context, self.color.CGColor);
            CGContextSetLineWidth(context, 3);
            shapeRect = CGRectMake(self.startPosition.x, self.startPosition.y, fabs(self.startPosition.x - self.endPoint.x), fabs(self.startPosition.y - self.endPoint.y));
            CGContextAddRect(context, shapeRect);
            CGContextFillPath(context);
            break;
        case shapeTypeOval:
            CGContextSetFillColorWithColor(context, self.color.CGColor);
            CGContextSetLineWidth(context, 3);
            shapeRect = CGRectMake(self.startPosition.x, self.startPosition.y, fabs(self.startPosition.x - self.endPoint.x), fabs(self.startPosition.y - self.endPoint.y));
            CGContextAddEllipseInRect(context, shapeRect);
            CGContextFillPath(context);
            break;

            break;
        case shapeTypeImage:
            phoneSize  = self.image.size;
            CGPoint imagePoint = CGPointMake(self.endPoint.x - phoneSize.width * 0.5, self.endPoint.y - phoneSize.height * 0.5);
            
            [self.image drawAtPoint:imagePoint];
            
            break;
        default:
            break;
            
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint position  = [touch locationInView:self];
    self.startPosition = position;
    self.endPoint = position;
    if (self.type == shapeTypeLine) {
        
        self.lines = [NSMutableArray array];
        [self.lines addObject: [NSValue valueWithCGPoint:position]];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint position  = [touch locationInView:self];
    self.endPoint = position;
    
    if (self.type == shapeTypeLine) {
        [self.lines addObject:[NSValue valueWithCGPoint:position] ];
    }
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint position  = [touch locationInView:self];
    self.endPoint = position;
    
    if (self.type == shapeTypeLine) {
        [self.lines addObject:[NSValue valueWithCGPoint:position] ];
    }
    
    [self setNeedsDisplay];
    

}

- (UIImage *)image{
    if (!_image) {
        _image = [UIImage imageNamed:@"iphone"];
    }
    return _image;
}
@end
