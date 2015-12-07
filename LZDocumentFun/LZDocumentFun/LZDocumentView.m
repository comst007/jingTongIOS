//
//  LZDocumentView.m
//  LZDocumentFun
//
//  Created by comst on 15/12/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDocumentView.h"

typedef struct {
    
    NSInteger row;
    NSInteger column;
    
}gridIndex;

@interface LZDocumentView ()

@property (nonatomic, assign) CGSize blockSize;
@property (nonatomic, assign) CGSize gapSize;
@property (nonatomic, assign) gridIndex selectedIndex;
@end

@implementation LZDocumentView

- (void)drawRect:(CGRect)rect{
    
    if (self.currentModel == nil) {
        
        return;
        
    }
    
    for (NSInteger row  = 0; row < 8; row ++) {
        
        for (NSInteger column = 0; column < 8; column ++) {
            
            [self drawArRow:row column:column];
            
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self commonInit];
        
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit{
    
    self.blockSize = CGSizeMake(34, 34);
    self.gapSize = CGSizeMake(5, 5);
    _selectedIndex.row = NSNotFound;
    _selectedIndex.column = NSNotFound;
    
}

- (void)drawArRow:(NSInteger)row column:(NSInteger)column{
    
    CGFloat blockX = (7 - column) * (self.blockSize.width + self.gapSize.width);
    CGFloat blockY = row * (self.blockSize.height + self.gapSize.height);
    CGRect blockFrame = CGRectMake(blockX, blockY, self.blockSize.width, self.blockSize.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:blockFrame];
    UIColor *blockColor = [self.currentModel stateAtRow:row column:column] ? [UIColor blackColor] : [UIColor whiteColor];
    
    [blockColor setFill];
    [self.tintColor setStroke];
    
    
    [path fill];
    [path stroke];
    
    
}

- (void)setCurrentModel:(LZDocumentModel *)currentModel{
    
    _currentModel = currentModel;
    
    [self setNeedsDisplay];
}

- (gridIndex)tuchedGridIndexForTouches:(NSSet *)touches{
    
    gridIndex selectGrid;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSInteger i ;
    CGFloat distance;
    for (i = 0; i < 8; i ++) {
        distance = ( 7 - i) * (self.blockSize.width + self.gapSize.width) ;
        if (distance <= point.x) {
            break;
        }
    }
    selectGrid.column = i;
    
    for (i = 0; i < 8; i ++) {
        distance = i * (self.blockSize.height + self.gapSize.height);
        if (distance > point.y) {
            break;
        }
    }
    
    selectGrid.row = i - 1;
    
    return selectGrid;
}

- (void)toggedSelectBlock{
    
    [self.currentModel toggleStateAtRow:self.selectedIndex.row column:self.selectedIndex.column];
    
    [[self.currentModel.undoManager prepareWithInvocationTarget:self.currentModel] toggleStateAtRow:self.selectedIndex.row column:self.selectedIndex.column];
    
    [self setNeedsDisplay];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.selectedIndex = [self tuchedGridIndexForTouches:touches];
    [self toggedSelectBlock];
}

@end
