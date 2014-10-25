//
//  ChatBubbleTableViewCell.m
//  Passengr
//
//  Created by Árpád Kiss on 2014. 10. 25..
//  Copyright (c) 2014. Peabo Media Kft. All rights reserved.
//

#import "ChatBubbleTableViewCell.h"
#import "Helper.h"
#import "Message.h"

@implementation ChatBubbleTableViewCell {
    UILongPressGestureRecognizer* _gs;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.messageLabel.textColor = [Helper sharedInstance].mainColor;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _gs = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    [_gs setMinimumPressDuration:0.8];
    [self addGestureRecognizer:_gs];
}

-(void)onLongPress:(UILongPressGestureRecognizer*)gs {
    switch (gs.state) {
        case UIGestureRecognizerStateBegan: {
                self.dateLabel.text = [[Helper sharedInstance] dateDiff:self.message.date];
                [UIView animateWithDuration:0.1 animations:^{
                    self.dateLabel.alpha = 1;
                    [self setNeedsDisplay];
                }];
            }
            break;
        case UIGestureRecognizerStateEnded: {
                [self setNeedsLayout];
                [UIView animateWithDuration:0.1 animations:^{
                    self.dateLabel.alpha = 0;
                    [self setNeedsDisplay];
                }];
            }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
