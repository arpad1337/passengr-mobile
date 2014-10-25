//
//  SelectionTableViewCell.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.24..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import "SelectionTableViewCell.h"
#import "Helper.h"

@implementation SelectionTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect {
    self.selectionLabel.textColor = [Helper sharedInstance].secondaryColor;
}

@end
