//
//  MenuButton.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.26..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import "MenuButton.h"
#import "Helper.h"

@implementation MenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)configureButton:(UIImage*)icon withTitle:(NSString*)title {
    self.backgroundView.backgroundColor = [Helper sharedInstance].mainColor;
    self.iconImageView.image = icon;
    self.buttonTitleLabel.textColor = [Helper sharedInstance].secondaryColor;
    self.buttonTitleLabel.text = title;
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
