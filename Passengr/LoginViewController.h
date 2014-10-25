//
//  LoginViewController.h
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.23..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectorView.h"

@interface LoginViewController : UIViewController <
    SelectorViewDelegate
>

@property (weak, nonatomic) IBOutlet UIButton *setButton;

@property (nonatomic, strong) NSNumber* age;
@property (nonatomic, strong) NSString* gender;

@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIView *genderSelectorView;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIView *ageSelectorView;

@end
