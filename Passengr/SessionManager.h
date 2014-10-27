//
//  SessionManager.h
//  Passengr
//
//  Created by Árpád Kiss on 2014. 10. 27..
//  Copyright (c) 2014. Peabo Media Kft. All rights reserved.
//

@interface SessionManager : NSObject

@property (nonatomic, strong) NSString* gender;
@property (nonatomic, strong) NSNumber* age;

/**
 * gets singleton object.
 * @return singleton
 */
+ (SessionManager*)sharedInstance;

@end
