//
//  LZFontSizeTableViewController.m
//  LZFontFun
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFontSizeTableViewController.h"

@interface LZFontSizeTableViewController ()

@property (nonatomic, copy) NSArray *sizeArray;

@end
@implementation LZFontSizeTableViewController

- (void)viewDidLoad{
    
    self.sizeArray = @[@10, @20, @30, @40, @50, @60, @70, @80, @90, @100];
    self.navigationItem.title = self.fontName;
}

- (UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat fontSize = [self.sizeArray[indexPath.row] floatValue];
    
    UIFont *font = [UIFont fontWithName:self.fontName size:fontSize];
    
    return font;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sizeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZFontSizeCell"];
    
    cell.textLabel.text = @"Hello World";
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"fontSIze: %@", self.sizeArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    
    return font.ascender - font.descender + 25;
}
@end
