//
//  ViewController.m
//  LZBridgeControl
//
//  Created by comst on 15/12/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

#define kOfficerKey @"CommandingOfficerKey"
#define kAuthorizationCodeKy @"AuthoriationCodeKey"
#define kRankKey @"RankKey"
#define kWrapDriveKey @"WarpDriverKey"
#define kWrapFactorKey @"WrapFactorKey"
#define kFavoriteTeaKey @"favoriteTea"
#define kFavoriteCaptainKey @"favoriteCaptain"
#define kFavoriteGadgetKey @"favoriteGadget"
#define kFavoriteKlingonExpressKey @"favoriteKlingonExpression"
#define kFavoriteAlientKey @"favoriteAlien"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initLables];
}

- (void)initLables{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.officerLabel.text = [defaults valueForKey:kOfficerKey];
    self.authorizationCodeLabel.text = [defaults valueForKey:kAuthorizationCodeKy];
    self.rankLabel.text = [defaults valueForKey:kRankKey];
    
    BOOL isDriver = [defaults boolForKey:kWrapDriveKey];
    self.wrapDriverLabel.text = isDriver ? @"Yes" :@"No";
    
    self.factorLabel.text = [NSString stringWithFormat:@"%@", [defaults valueForKey:kWrapFactorKey]];
    
    self.teaLabel.text = [defaults valueForKey:kFavoriteTeaKey];
    self.captainLabel.text = [defaults valueForKey:kFavoriteCaptainKey];
    self.gadgetLabel.text = [defaults valueForKey:kFavoriteGadgetKey];
    self.klingonLabel.text = [defaults valueForKey:kFavoriteKlingonExpressKey];
    self.alienLabel.text = [defaults valueForKey:kFavoriteAlientKey];
    
}



@end
