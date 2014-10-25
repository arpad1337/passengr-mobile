//
//  Helper.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.23..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import "Helper.h"
#import "AVHexColor/AVHexColor.h"

@implementation Helper

static Helper *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[Helper alloc] init];
}

- (id)mutableCopy
{
    return [[Helper alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    if(self = [super init]) {
        self.mainColor = [AVHexColor colorWithHex:0x4CCFFF];
        self.secondaryColor = [AVHexColor colorWithHex:0xFFFFFF];
    }
    return self;
}

-(NSString *)dateDiff:(NSDate*)date {
    NSDate *todayDate = [NSDate date];
    double ti = [date timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
        return @"now";
    } else 	if (ti < 60) {
        return @"<1m";
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%dm", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        return[NSString stringWithFormat:@"%dh", diff];
    } else if (ti < 604800) {
        int diff = round(ti / 60 / 60 / 24);
        return[NSString stringWithFormat:@"%dd", diff];
    } else {
        int diff = round(ti / 60 / 60 / 24 / 7);
        return[NSString stringWithFormat:@"%dw", diff];
    }
}


@end
