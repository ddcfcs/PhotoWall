//
//  UploadImageViewController.m
//  PhotoWall
//
//  Created by Cruise on 14-8-21.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import "UploadImageViewController.h"
#import <Parse/Parse.h>

@interface UploadImageViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgToUpload;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendButton;

@end

@implementation UploadImageViewController
@synthesize imgToUpload = _imgToUpload;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)selectPicturePressed:(id)sender
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentModalViewController:imgPicker animated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissModalViewControllerAnimated:YES];
    self.imgToUpload.image = image;
}

- (IBAction)sendPressed:(id)sender
{
    self.sendButton.enabled = NO;
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    loadingSpinner.color = [UIColor blueColor];         //不设置颜色的话，用默认颜色可能看不到loadingSpinner
    [loadingSpinner startAnimating];
    //loadingSpinner.hidesWhenStopped = NO;
    [self.view addSubview:loadingSpinner];
    
    NSData *pictureData = UIImagePNGRepresentation(self.imgToUpload.image);
    PFFile *file = [PFFile fileWithName:@"img" data:pictureData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            PFObject *imageObject = [PFObject objectWithClassName:@"Picture"];
            [imageObject setObject:file forKey:@"image"];
            //[imageObject setObject:[PFUser currentUser].usernameforKey:@"User"];
            //[imageObject setObject:self.commentTextField.textforKey:@"comment"];
           
            [imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                 [loadingSpinner stopAnimating];
                self.sendButton.enabled = YES;
                [self.delegate addPhotosOnTheWall:self photoAdded:self.imgToUpload.image];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
//    [self.delegate addPhotosOnTheWall:self photoAdded:self.imgToUpload.image];
//    [self.navigationController popViewControllerAnimated:YES];
}




@end
