//
//  Message.h
//  Passengr
//
//  Created by Árpád Kiss on 2014. 10. 25..
//  Copyright (c) 2014. Peabo Media Kft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MessageType) {
    notification,
    own,
    partner
};


@interface Message : NSObject

@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic) MessageType type;

@end
