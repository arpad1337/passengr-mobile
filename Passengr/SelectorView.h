//
//  SelectorView.h
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.24..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILTranslucentView/ILTranslucentView.h"

@interface SelectorView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UITableView *selectionTableView;
@property (nonatomic, strong) NSArray* data;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void)configureView;

@end


@protocol SelectorViewDelegate <NSObject>

-(void)selectionDidChange:(id)value;
-(void)selectionDidCancel;

@end