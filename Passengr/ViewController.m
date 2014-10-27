//
//  ViewController.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.19..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import "ViewController.h"
#import "SessionManager.h"
#import "Helper.h"
#import "LoginViewController.h"
#import "ChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *launchImage;
    if  ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) &&
         ([UIScreen mainScreen].bounds.size.height > 480.0f)) {
        launchImage = @"LaunchImage-700-568h";
    } else {
        launchImage = @"LaunchImage-700";
    }
    [self.backgroundImageView setImage:[UIImage imageNamed:launchImage]];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(![SessionManager sharedInstance].age || ![SessionManager sharedInstance].gender) {
        LoginViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        ChatViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewControllerID"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
