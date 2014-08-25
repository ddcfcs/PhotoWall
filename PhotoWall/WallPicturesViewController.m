//
//  WallPicturesViewController.m
//  PhotoWall
//
//  Created by Cruise on 14-8-25.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import "WallPicturesViewController.h"
#import "UploadImageViewController.h"

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
    //[imgView sizeToFit];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:
                            CGRectMake(10.0f, 10.0f, 200.0f, 150.0f)];
    [imgView setImage:photo];
//    imgView.center = CGPointMake(x, y);
    [self.view addSubview:imgView];
}

@end
