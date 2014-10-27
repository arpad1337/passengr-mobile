//
//  SessionManager.m
//  Passengr
//
//  Created by Árpád Kiss on 2014. 10. 27..
//  Copyright (c) 2014. Peabo Media Kft. All rights reserved.
//

#import "SessionManager.h"
#define MR_SHORTHAND
#import "CoreData+MagicalRecord.h"

#define NULLIFNIL(foo) ((foo == nil) ? [NSNull null] : foo)

@implementation SessionManager

static SessionManager *SINGLETON = nil;

static bool isFirstAccess = YES;

static NSString* APIURI = @"http://prod.passengr.me";

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
    return [[SessionManager alloc] init];
}

- (id)mutableCopy
{
    return [[SessionManager alloc] init];
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
        [self openSocketConnection];
    };
    return self;
}

#pragma mark - Setters

-(void)performLogout {
    
}
-(void)performLogin {
    if(!([NULLIFNIL(_gender) isEqual:[NSNull null]]) &&
       !([NULLIFNIL(_age) isEqual:[NSNull null]])
    ) {
        NSLog(@"AUTH");
    }
}

#pragma mark - WebSocket handler

-(void)openSocketConnection {
    
}

@end
