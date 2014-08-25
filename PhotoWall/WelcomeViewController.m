//
//  WelcomeViewController.m
//  TestBedViewController
//
//  Created by Cruise on 14-7-24.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonRegister;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;

@end

@implementation WelcomeViewController

@synthesize buttonRegister = _buttonRegister;
@synthesize buttonLogin = _buttonLogin;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.buttonRegister.backgroundColor = HEXCOLOR(0x34ad00ff);
	self.buttonLogin.backgroundColor = HEXCOLOR(0x205081ff);
    [self.buttonRegister.layer setCornerRadius:20];
    [self.buttonLogin.layer setCornerRadius:20];
}
- (BOOL)shouldAutorotate    //组织屏幕内容跟随屏幕旋转的，但是没反应，是因为在模拟器的缘故吗？
{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showRegister"]) {
        //[segue.destinationViewController ]
    }
}





@end
