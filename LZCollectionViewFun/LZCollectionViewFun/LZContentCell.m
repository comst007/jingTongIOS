//
//  LZContentCell.m
//  LZCollectionViewFun
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZContentCell.h"

@interface LZContentCell ()



@end
@implementation LZContentCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.contentLabel];
        self.contentLabel.font = [[self class] contentFont];
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

+ (UIFont *)contentFont{
    
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];

    return font;
}

+ (CGSize)sizeofContentString:(NSString *)content{
    
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, 30);
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attDic = @{NSFontAttributeName : [[self class] contentFont], NSForegroundColorAttributeName:[UIColor cyanColor], NSParagraphStyleAttributeName:paraStyle};
    
  CGRect rect = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    
    return rect.size;
}

- (void)setText:(NSString *)text{
    
    _text = text;
    self.contentLabel.text = text;
    CGSize newSize = [[self class] sizeofContentString:text];
    CGRect labelFrame = self.contentLabel.frame;
    labelFrame.size = newSize;
    self.contentLabel.frame = labelFrame;
    
    CGRect contentViewFrame = self.contentView.frame;
    
    contentViewFrame.size = newSize;
    
    self.contentView.frame = contentViewFrame;
}
@end
