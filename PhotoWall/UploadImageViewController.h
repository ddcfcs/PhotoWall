//
//  UploadImageViewController.h
//  PhotoWall
//
//  Created by Cruise on 14-8-21.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UploadImageViewController;

@protocol AddPhotosDelegate <NSObject>

- (void)addPhotosOnTheWall:(UploadImageViewController*)sender
                photoAdded:(UIImage*)photo;

@end

@interface UploadImageViewController : UIViewController

@property (nonatomic,weak) id<AddPhotosDelegate> delegate;

@end
