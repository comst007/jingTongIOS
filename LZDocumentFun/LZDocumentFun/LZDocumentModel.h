//
//  LZDocumentModel.h
//  LZDocumentFun
//
//  Created by comst on 15/12/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZDocumentModel : UIDocument

- (BOOL)stateAtRow:(NSInteger)row column:(NSInteger)column;

- (void)setState: (BOOL)state AtRow:(NSInteger)row column:(NSInteger)column;

- (void)toggleStateAtRow:(NSInteger)row column:(NSInteger)column;
@end
