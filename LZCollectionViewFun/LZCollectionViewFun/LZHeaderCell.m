//
//  LZHeaderCell.m
//  LZCollectionViewFun
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZHeaderCell.h"


@implementation LZHeaderCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentLabel.font = [[self class] contentFont];
        self.contentLabel.backgroundColor = [UIColor blackColor];
        self.contentLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

+ (UIFont *)contentFont{
    
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
}
@end
