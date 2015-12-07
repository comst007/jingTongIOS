//
//  LZDocumentModel.m
//  LZDocumentFun
//
//  Created by comst on 15/12/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDocumentModel.h"

@interface LZDocumentModel ()

@property (nonatomic, strong) NSMutableData *bitmap;

@end

@implementation LZDocumentModel

- (instancetype)initWithFileURL:(NSURL *)url{
    
    self = [super initWithFileURL:url];
    
    if (self) {
        char bitarray[] = {
            
            0x01,
            0x02,
            0x04,
            0x08,
            0x10,
            0x20,
            0x40,
            0x80
        };
        
        self.bitmap = [NSMutableData dataWithBytes:bitarray length:8];
        
    }
    
    return self;
}

- (BOOL)stateAtRow:(NSInteger)row column:(NSInteger)column{
    
    char *bytesArray = (char *)self.bitmap.bytes;
    
    char dataAtRow = bytesArray[row];
    
    char result = dataAtRow & (1 << column);
    
    if (result) {
        
        return YES;
    }
    
    return NO;
}

- (void)setState: (BOOL)state AtRow:(NSInteger)row column:(NSInteger)column{
    
    char* bytesM = (char *)self.bitmap.mutableBytes;
    
    char *dataAtRow = bytesM + row;
    
    if  (state) {
        
        *dataAtRow = *dataAtRow | (1 << column);
        
    }else{
        
        *dataAtRow = *dataAtRow & ~(1 << column);
        
    }
}

- (void)toggleStateAtRow:(NSInteger)row column:(NSInteger)column{
    
    BOOL state = [self stateAtRow:row column:column];
    
    [self setState:!state AtRow:row column:column];
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError{
    
    return [self.bitmap copy];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError{
    
    self.bitmap = [contents mutableCopy];
    
    return YES;
}

@end
