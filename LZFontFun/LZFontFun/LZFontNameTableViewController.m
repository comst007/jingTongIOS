//
//  LZFontNameTableViewController.m
//  LZFontFun
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFontNameTableViewController.h"
#import "LZFavoriteList.h"
#import "LZFontSizeTableViewController.h"
#import "LZDetailViewController.h"
@interface LZFontNameTableViewController ()

@property (nonatomic, copy) NSArray *fontArray;
@property (nonatomic, assign) CGFloat fontSize;

@end

@implementation LZFontNameTableViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self fontSizeInit];
    if (self.isShowFavorite == YES) {
         self.navigationItem.title = @"favorite";
    }else{
        
    self.navigationItem.title = self.familyName;
        
    }
    if (self.isShowFavorite) {
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)fontSizeInit{
    
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.fontSize = [font pointSize];
    
}

- (void)setFamilyName:(NSString *)familyName{
    
    _familyName = familyName;
    
    self.fontArray = [UIFont fontNamesForFamilyName:familyName];
    
}

- (UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *fontName = self.fontArray[indexPath.row];
    
    UIFont *font = [UIFont fontWithName:fontName size:self.fontSize];
    
    return font;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.isShowFavorite) {
        
        return [LZFavoriteList sharedList].favoriteList.count;
        
    }else{
        
        return self.fontArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZFontNameCell"];
    
    if (self.isShowFavorite == YES) {
        cell.textLabel.text = [[LZFavoriteList sharedList].favoriteList objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [[LZFavoriteList sharedList].favoriteList objectAtIndex:indexPath.row];
        
    }else{
        cell.textLabel.text = [self.fontArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = self.fontArray[indexPath.row];
    }
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    
    return font.ascender - font.descender + 25;
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.isShowFavorite;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.isShowFavorite;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isShowFavorite) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    [[LZFavoriteList sharedList] moveItemFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isShowFavorite == NO) {
        return;
    }
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[LZFavoriteList sharedList] deleteItemAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showFontSize"]) {
        
        LZFontSizeTableViewController *VC = (LZFontSizeTableViewController *)segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if (self.isShowFavorite) {
            
            VC.fontName = [LZFavoriteList sharedList].favoriteList[indexPath.row];;

        }
        else{
            
            VC.fontName = self.fontArray[indexPath.row];
        }
    }
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        
        LZDetailViewController *VC = (LZDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        if (self.isShowFavorite) {
            
            VC.fontName = [LZFavoriteList sharedList].favoriteList[indexPath.row];;
            VC.isFavorite = self.isShowFavorite;
        }
        else{
            
            VC.fontName = self.fontArray[indexPath.row];
            VC.isFavorite = [[LZFavoriteList sharedList].favoriteList containsObject:VC.fontName];
        }
        
       
    }
}
@end
