//
//  AlertView.h
//  Passengr
//
//  Created by Árpád Kiss on 2014.08.06..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AlertType) {
    kReport
};

@interface AlertView : UIView
@property (weak, nonatomic) IBOutlet UIView *backgroundFrameView;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okayButton;

@property(assign, nonatomic) id delegate;

-(void)dropAlertWithTitle:(NSString*)title withDescription:(NSString*)desctiption andType:(AlertType)type;

@end

@protocol AlertViewDelegate <NSObject>

-(void)alertViewDidCancel:(AlertView*)alertView withType:(AlertType)type;
-(void)alertViewDidAccept:(AlertView *)alertView withType:(AlertType)type;

@end