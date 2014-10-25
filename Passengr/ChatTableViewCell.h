//
//  ChatTableViewCell.h
//  Passengr
//
//  Created by Árpád Kiss on 2014. 10. 25..
//  Copyright (c) 2014. Peabo Media Kft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface ChatTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, assign) Message* message;

@end
