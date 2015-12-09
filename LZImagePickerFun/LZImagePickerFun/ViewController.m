//
//  ViewController.m
//  LZImagePickerFun
//
//  Created by comst on 15/12/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
// "public.image",
//"public.movie"

static NSString * const kTypeMovie = @"public.movie";
static NSString * const kTypeImage = @"public.image";

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *pickerButton;
@property (nonatomic, assign) UIImagePickerControllerSourceType sourceType;
@property (nonatomic, copy) NSString *mediaType;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSURL *movieURL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerButton.layer.cornerRadius = 15;
    self.pickerButton.layer.masksToBounds = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self configDispalyView];
}

- (void)configDispalyView{
    
    if ([self.mediaType isEqualToString:kTypeImage]) {
        [self showImageView];
    }else if([self.mediaType isEqualToString:kTypeMovie])
    {
        [self showMovieView];
    }else{
        return;
    }
}

- (void)clearMoviePlayerController{
    [self.moviePlayerController.view removeFromSuperview];
    self.moviePlayerController = nil;
}

- (void)showImageView{
    
    [self clearMoviePlayerController];
    self.imageView.hidden = NO;
    self.imageView.image = self.image;
}

- (void)showMovieView{
    
    [self clearMoviePlayerController];
    
    self.imageView.hidden = YES;
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:self.movieURL];
    
    [self.view addSubview:self.moviePlayerController.view];
    self.moviePlayerController.view.frame = self.imageView.frame;
    self.moviePlayerController.view.clipsToBounds = YES;
    [self.moviePlayerController play];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"photo" message:@"select photo from" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionFromCamera = [UIAlertAction actionWithTitle:@"camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self showPickView];
    }];
    
    UIAlertAction *actionFromLibrary = [UIAlertAction actionWithTitle:@"library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self showPickView];
    }];
    
    UIAlertAction *actionFromAlbum = [UIAlertAction actionWithTitle:@"album" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self showPickView];
    }];
    
    [alertVC addAction:actionFromCamera];
    [alertVC addAction:actionFromLibrary];
    [alertVC addAction:actionFromAlbum];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)showPickView{
    
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    BOOL state = [UIImagePickerController isSourceTypeAvailable:self.sourceType];
    
    
    if (state) {
        pickerVC.sourceType = self.sourceType;
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.sourceType];
        NSLog(@"MediaTypes: %@", mediaTypes);
        pickerVC.mediaTypes = mediaTypes;

    }else{
        NSLog(@"source not available");
        return;
    }
    
    pickerVC.allowsEditing = YES;
    pickerVC.delegate = self;
    [self presentViewController:pickerVC animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSLog(@"info: %@", info);
    [self getImageOrMovieByInfo:info];
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

- (void)getImageOrMovieByInfo:(NSDictionary *)info{
    
    self.mediaType = info[UIImagePickerControllerMediaType];
    if ([self.mediaType isEqualToString:kTypeImage]) {
        
        UIImage *image ;
        image = info[UIImagePickerControllerEditedImage];
        self.image = [self shrinkImage:image toSize:self.imageView.frame.size];
        
    }else if ([self.mediaType isEqualToString:kTypeMovie]){
        self.movieURL = info[UIImagePickerControllerMediaURL];
    }
}

- (UIImage *)shrinkImage:(UIImage *)image toSize:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGSize sourceSize = image.size;
    CGRect targetRect = CGRectZero;
    CGFloat sourceAspect = sourceSize.width / sourceSize.height;
    CGFloat targetAspect = size.width / size.width;
    
    if (sourceAspect > targetAspect) {
        
        targetRect.size.width = size.width;
        targetRect.size.height = size.width / sourceAspect;
        targetRect.origin.x = 0;
        targetRect.origin.y = (size.height - targetRect.size.height) * 0.5;
        
    }else if (sourceAspect < targetAspect){
        
        targetRect.size.height = size.height;
        targetRect.size.width = size.height * sourceAspect;
        targetRect.origin.y = 0;
        targetRect.origin.x = (size.width - targetRect.size.width) * 0.5;
        
    }else{
        
        targetRect = CGRectMake(0, 0, size.width, size.height);
    }
    [image drawInRect:targetRect];
    
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}
@end
