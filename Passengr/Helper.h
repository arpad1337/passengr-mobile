//
//  Helper.h
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.23..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

@interface Helper : NSObject

@property (nonatomic, strong) UIColor* mainColor;
@property (nonatomic, strong) UIColor* secondaryColor;

@property (nonatomic, strong) NSString* gender;
@property (nonatomic, strong) NSNumber* age;

/**
 * gets singleton object.
 * @return singleton
 */
+ (Helper*)sharedInstance;

-(NSString *)dateDiff:(NSDate*)date;

@end