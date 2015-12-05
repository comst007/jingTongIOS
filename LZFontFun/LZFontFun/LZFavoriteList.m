//
//  LZFavoriteList.m
//  LZFontFun
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFavoriteList.h"

#define kFavoriteFontKey  @"LZFavoriteFontKey"

@interface LZFavoriteList ()

@property (nonatomic, strong) NSMutableArray *favoriteList;

@end


static LZFavoriteList  *instance = nil;

@implementation LZFavoriteList


+ (instancetype)sharedList{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        instance.favoriteList = [defaults valueForKey:kFavoriteFontKey];
        if (instance.favoriteList == nil) {
            
            instance.favoriteList = [NSMutableArray array];
            
        }
    });
    
    return instance;
}

- (void)addNewItem:(NSString *)item{
    
    [_favoriteList insertObject:item atIndex:0];
    [self save];
}

- (void)deleteItemAtIndex:(NSInteger)index{
    
    [_favoriteList removeObjectAtIndex:index];
    [self save];
    
}

- (void)moveItemFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    
    NSString *item = [_favoriteList objectAtIndex:fromIndex];
    [_favoriteList removeObjectAtIndex:fromIndex];
    [_favoriteList insertObject:item atIndex:toIndex];
    [self save];
}


- (void)save{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setValue:_favoriteList forKey:kFavoriteFontKey];
    
    [defaults synchronize];
    
}


@end
