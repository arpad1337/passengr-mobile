//
//  ChatViewController.h
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.25..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutView.h"
#import "AlertView.h"

@interface ChatViewController : UIViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    UITextFieldDelegate,
    AboutViewDelegate,
    AlertViewDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *toggleMenuButton;
@property (weak, nonatomic) IBOutlet UIView *headerContainerView;

@property (weak, nonatomic) IBOutlet UIView *inputContainerView;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

@property (weak, nonatomic) IBOutlet UITableView *messagesTableView;

@end
