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

/**
 * gets singleton object.
 * @return singleton
 */
+ (Helper*)sharedInstance;

-(NSString *)dateDiff:(NSDate*)date;

@end

@implementation UITextField (custom)
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 10, bounds.origin.y,
                      bounds.size.width - 10, bounds.size.height);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}
@end