//
//  LZFavoriteList.h
//  LZFontFun
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZFavoriteList : NSObject

- (NSArray *)favoriteList;

- (void)addNewItem:(NSString *)item;

- (void)deleteItemAtIndex:(NSInteger)index;

- (void)moveItemFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

+ (instancetype)sharedList;

@end
