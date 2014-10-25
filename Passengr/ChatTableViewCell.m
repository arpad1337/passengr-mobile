//
//  ChatTableViewCell.m
//  Passengr
//
//  Created by Árpád Kiss on 2014. 10. 25..
//  Copyright (c) 2014. Peabo Media Kft. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (void)awakeFromNib {
    self.preservesSuperviewLayoutMargins = NO;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width);
    self.dateLabel.alpha = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMessage:(Message*)message {
    _message = message;
    self.messageLabel.text = message.message;
    [self setNeedsDisplay];
}

@end
