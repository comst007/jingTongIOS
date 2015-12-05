//
//  LZFontsTableViewController.m
//  LZFontFun
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFontsTableViewController.h"
#import "LZFavoriteList.h"
#import "LZFontNameTableViewController.h"
@interface LZFontsTableViewController ()

@property (nonatomic, copy) NSArray *fontArray;
@property (nonatomic, assign) CGFloat fontSize;
@end

@implementation LZFontsTableViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self fontSizeInit];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)fontSizeInit{
    
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.fontSize = [font pointSize];
    
}


- (NSArray *)fontArray{
    if (!_fontArray) {
        
        _fontArray = [UIFont familyNames];
        
    }
    return _fontArray;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 ) {
        
        return self.fontArray.count;
        
    }else{
        
        return 1;
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([LZFavoriteList sharedList].favoriteList.count == 0) {
        
        return 1;
        
    }else{
        
        return 2;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return @"All Fonts";
        
    }else{
        
        return @"Favorites Fonts";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
        
        return font.ascender - font.descender + 25;
    }
    
    return self.tableView.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"LZFontFamilyCell"];
        cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
        cell.textLabel.text = self.fontArray[indexPath.row];
        
        cell.detailTextLabel.text = self.fontArray[indexPath.row];
        
    }else{
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"LZFavoriteCell"];
        cell.textLabel.text = @"favoriteFonts";
        
    }
    
    return cell;
}

- (UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        NSString *familyName = self.fontArray[indexPath.row];
        NSString *fontName = [[UIFont fontNamesForFamilyName:familyName] firstObject];
        
        UIFont *font = [UIFont fontWithName:fontName size:self.fontSize];
        
        return font;
    }
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    LZFontNameTableViewController *VC = (LZFontNameTableViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    
    if ([segue.identifier isEqualToString:@"showFont"]) {
        
        VC.familyName = self.fontArray[indexPath.row];
        VC.isShowFavorite = NO;
        
    }
    
    if ([segue.identifier isEqualToString:@"showFavorite"]) {
        VC.isShowFavorite = YES;
    }
}
@end
