//
//  MenuButton.h
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.26..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuButton : UIButton

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *buttonTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

-(void)configureButton:(UIImage*)icon withTitle:(NSString*)title;

@end