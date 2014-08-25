//
//  RegisterViewController.m
//  PhotoWall
//
//  Created by Cruise on 14-8-20.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>

@interface RegisterViewController () <UITextFieldDelegate>                     //记得把self设置为UITextField的代理
@property (weak, nonatomic) IBOutlet UITextField *userRegisterText;
@property (weak, nonatomic) IBOutlet UITextField *passwordRegisterText;
@end

@implementation RegisterViewController
@synthesize userRegisterText = _userRegisterText;
@synthesize passwordRegisterText = _passwordRegisterText;

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
    self.userRegisterText.delegate = self;
    self.passwordRegisterText.delegate = self;
    
}

- (IBAction)signUpUserPressed:(id)sender
{
    PFUser *user = [PFUser user];
    user.username = self.userRegisterText.text;
    user.password = self.passwordRegisterText.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error) {
            [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
        }else{
            NSString *errorString = [[error userInfo]objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:@"Error"message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
        
    }];
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
