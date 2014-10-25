//
//  ChatLeftBubbleTableViewCell.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.25..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import "ChatLeftBubbleTableViewCell.h"
#import "Helper.h"

@implementation ChatLeftBubbleTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect {
    CGRect r = [self.message.message boundingRectWithSize:CGSizeMake(200, 0)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                        context:nil];
    
    self.messageLabel.frame = CGRectMake(self.messageLabel.frame.origin.x, self.messageLabel.frame.origin.y, self.messageLabel.frame.size.width, r.size.height + 4);
    CGFloat width = 232;
    if(r.size.width < 190) {
        width = r.size.width + 30;
    }
    self.bubbleImageView.frame = CGRectMake(self.bubbleImageView.frame.origin.x, self.bubbleImageView.frame.origin.y, width, self.bubbleImageView.frame.size.height);
}

@end
