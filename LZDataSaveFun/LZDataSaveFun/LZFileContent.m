//
//  LZFileContent.m
//  LZDataSaveFun
//
//  Created by comst on 15/12/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFileContent.h"

#define kContentKey @"fileContent"

@implementation LZFileContent

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        self.content = [aDecoder decodeObjectForKey:kContentKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.content forKey:kContentKey];
    
}
@end
