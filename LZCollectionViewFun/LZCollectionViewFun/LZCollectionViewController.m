//
//  LZCollectionViewController.m
//  LZCollectionViewFun
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZCollectionViewController.h"
#import "LZContentCell.h"
#import "LZHeaderCell.h"
#define kContentCellIdentifier @"LZContentCellKey"
#define kContentHeaderIdentifier @"LZHeaderCellKey"

@interface LZCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) NSArray *contens;

@end
@implementation LZCollectionViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self registerCellClasses];
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    flowLayout.headerReferenceSize = CGSizeMake(100, 30);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(50, 50, 50, 50);
}


- (void)registerCellClasses{
    
    [self.collectionView registerClass:[LZContentCell class] forCellWithReuseIdentifier:kContentCellIdentifier];
    [self.collectionView registerClass:[LZHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kContentHeaderIdentifier];
}

- (NSArray *)contens{
    if (!_contens) {
        _contens = @[
                     
                     @{ @"header" : @"First Witch",
                        @"content" : @"Hey, when will the three of us meet up later?" },
                     @{ @"header" : @"Second Witch",
                        @"content" : @"When everything's straightened out." },
                     @{ @"header" : @"Third Witch",
                        @"content" : @"That'll be just before sunset." },
                     @{ @"header" : @"First Witch",
                        @"content" : @"Where?" },
                     @{ @"header" : @"Second Witch",
                        @"content" : @"The dirt patch." },
                     @{ @"header" : @"Third Witch",
                        @"content" : @"I guess we'll see Mac there." },

                     ];
    }
    return _contens;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.contens.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSString *line = self.contens[section][@"content"];
    
    
    NSArray *words = [self wordsOfLine:line];
    
    return words.count;
    
}

- (NSArray *)wordsOfLine:(NSString *)line{
    
    NSCharacterSet *splitSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSArray *words = [line componentsSeparatedByCharactersInSet:splitSet];
    
    return words;
}

- (NSArray *)wordsOfLineAtIndex:(NSInteger)section{
    
    NSString *line = self.contens[section][@"content"];
    
    return [self wordsOfLine:line];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LZContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellIdentifier forIndexPath:indexPath];
    NSArray *words = [self wordsOfLineAtIndex:indexPath.section];
    
    cell.text = words[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        LZHeaderCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kContentHeaderIdentifier forIndexPath:indexPath];
        cell.text = self.contens[indexPath.section][@"header"];
        
        return cell;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self wordsOfLineAtIndex:indexPath.section];
    CGSize size = [LZContentCell sizeofContentString:words[indexPath.row]];
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}


@end
