//
//  SnapshotViewController.h
//  Passengr
//
//  Created by Árpád Kiss on 2014.08.26..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnapshotViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) IBOutlet UIView *toolbarContainerView;
@property (weak, nonatomic) IBOutlet UIButton *snapshotButton;
@property (weak, nonatomic) IBOutlet UIButton *directoryButton;
@property (weak, nonatomic) IBOutlet UIButton *changeFlashButton;
@property (weak, nonatomic) IBOutlet UIButton *switchCameraButton;

@end
