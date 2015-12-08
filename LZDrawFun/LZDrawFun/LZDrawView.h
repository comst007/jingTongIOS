//
//  LZDrawView.h
//  LZDrawFun
//
//  Created by comst on 15/12/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, shapeType) {
    shapeTypeLine,
    shapeTypeRectangle,
    shapeTypeOval,
    shapeTypeImage
};

@interface LZDrawView : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) shapeType type;

@end
