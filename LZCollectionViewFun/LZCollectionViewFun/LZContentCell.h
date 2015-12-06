//
//  LZContentCell.h
//  LZCollectionViewFun
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZContentCell : UICollectionViewCell

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UILabel *contentLabel;
+ (CGSize)sizeofContentString:(NSString *)content;

+ (UIFont *)contentFont;

@end
