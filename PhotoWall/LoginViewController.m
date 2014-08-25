//
//  LoginViewController.m
//  PhotoWall
//
//  Created by Cruise on 14-8-18.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController () <UITextFieldDelegate>                     //记得把self设置为UITextField的代理
@property (weak, nonatomic) IBOutlet UITextField *userLoginText;
@property (weak, nonatomic) IBOutlet UITextField *passwordLoginText;

@end

@implementation LoginViewController
@synthesize userLoginText = _userLoginText;
@synthesize passwordLoginText = _passwordLoginText;

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
    self.userLoginText.delegate = self;
    self.passwordLoginText.delegate = self;
}


- (IBAction)LoginPressed:(id)sender
{
    //异步登录 ，但是 效果与同步一样
    [PFUser logInWithUsernameInBackground:self.userLoginText.text password:self.passwordLoginText.text block:^(PFUser *user, NSError *error) {
        if (!error) {
            //******************************特别注意***********************************
            //segue的链接方式应该是两个viewController之间，而不是LoginViewController的button segue到 photoWall
            [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
        }else{
            NSString *errorString = [[error userInfo]objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [errorAlertView show];
        }
    }];
    
    //同步登录 ， 但是 效果与异步一样
//    NSError* error;
//    [PFUser logInWithUsername:self.userLoginText.text password:self.passwordLoginText.text error:&error];
//    if (!error) {
//        [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
//    }else{
//        NSString *errorString = [[error userInfo]objectForKey:@"error"];
//        UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [errorAlertView show];
//    }
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text length]) {
        [textField resignFirstResponder];
        //[[self presentingViewController] dismissModalViewControllerAnimated:YES];
        return YES;
    }
    return NO;
}








@end
