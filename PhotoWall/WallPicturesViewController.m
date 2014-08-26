//
//  WallPicturesViewController.m
//  PhotoWall
//
//  Created by Cruise on 14-8-25.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import "WallPicturesViewController.h"
#import "UploadImageViewController.h"
#import <Parse/Parse.h>

@interface WallPicturesViewController ()    <AddPhotosDelegate,UIActionSheetDelegate>

@end

@implementation WallPicturesViewController
@synthesize wallObjectsArray = _wallObjectsArray;

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
    [self getWallImages];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier hasPrefix:@"Select Picture"]) {
        ((UploadImageViewController*)segue.destinationViewController).delegate = self;          //相当重要
    }
}

-(void) setRandomLocationForView:(UIView*)view
{
    [view sizeToFit];
    CGRect sinkBounds = CGRectInset(self.view.bounds, view.frame.size.width/2, view.frame.size.height/2);
    CGFloat x = arc4random()%(int)sinkBounds.size.width+view.frame.size.width/2;
    CGFloat y = arc4random()%(int)sinkBounds.size.height+view.frame.size.height/2;
    view.center = CGPointMake(x, y);
}

- (void)addPhotosOnTheWall:(UploadImageViewController *)sender photoAdded:(UIImage *)photo
{
    //UIImageView *imgView = [[UIImageView alloc ] initWithImage:photo];
    //[self setRandomLocationForView:photo];

    CGRect rect = CGRectInset(self.view.bounds, self.view.frame.size.width/3, self.view.frame.size.height/3);
//    CGFloat x = arc4random()%(int)rect.size.width+self.view.frame.size.width/3;
//    CGFloat y = arc4random()%(int)rect.size.height+self.view.frame.size.height/3;
    CGFloat x1 = self.view.frame.size.width;
    CGFloat y1 = self.view.frame.size.height;
    CGFloat x = arc4random()%(320-50);
    CGFloat y = arc4random()%(480-80)+rect.size.height/2;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:
                           rect];
    [imgView setImage:photo];
    imgView.contentMode = UIViewContentModeScaleAspectFit;                  //保持图片比例
    imgView.center = CGPointMake(x, y);
    [self.view addSubview:imgView];
}




//Get the list of images
-(void)getWallImages
{
    PFQuery *query = [PFQuery queryWithClassName:@"Picture"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        if(!error){
            //Everything was correct,put the new objects and load the wall
            self.wallObjectsArray = nil;
            self.wallObjectsArray = [[NSArray alloc] initWithArray:objects];
            [self loadWallViews];
        }else{
            NSString *errorString = [[error userInfo]objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}


-(void)loadWallViews
{
    CGFloat originY = 100;
    for(PFObject *wallObject in self.wallObjectsArray){

        //Build the view with the image
        UIView *wallImageView = [[UIView alloc] initWithFrame:CGRectMake(10, originY, self.view.frame.size.width/2, 100)];

        //add the image
        PFFile *image = (PFFile*)[wallObject objectForKey:@"image"];
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
        userImage.contentMode = UIViewContentModeScaleAspectFit;
        userImage.frame = CGRectMake(0, 0, wallImageView.frame.size.width, 100);
        [wallImageView addSubview:userImage];

        [self.view addSubview:wallImageView];
        
        originY = originY + wallImageView.frame.size.width/2 +30;
        
    }
    
    
}




@end
