//
//  AboutView.h
//  Passengr
//
//  Created by Árpád Kiss on 2014.08.06..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray* labels;
@property (weak, nonatomic) IBOutlet UIView *buttonBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *shareButtonLabel;

@property (nonatomic, assign) id delegate;

@end

@protocol AboutViewDelegate <NSObject>

-(void)closeButtonPressed;

@end
