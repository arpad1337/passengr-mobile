//
//  ChatRightBubbleTableViewCell.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.26..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import "ChatRightBubbleTableViewCell.h"
#import "Helper.h"

@implementation ChatRightBubbleTableViewCell

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
    NSLog(@"%@",self.message.message);
    CGRect r = [self.message.message boundingRectWithSize:CGSizeMake(200, 0)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                      context:nil];
    
    self.messageLabel.frame = CGRectMake(self.messageLabel.frame.origin.x, self.messageLabel.frame.origin.y, self.messageLabel.frame.size.width, r.size.height + 4);
    CGFloat width = 232;
    if(r.size.width < 190) {
        width = r.size.width + 30;
    }
    
    self.bubbleImageView.frame = CGRectMake(self.frame.size.width - 20 - width, self.bubbleImageView.frame.origin.y, width, self.bubbleImageView.frame.size.height);
}

@end

