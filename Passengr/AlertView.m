//
//  AlertView.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.08.06..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import "AlertView.h"
#import "Helper.h"

#define animDur 0.2

@implementation AlertView {
    CGRect _origFrame;
    CGRect _hiddenFrame;
    CGRect _destFrame;
    CGFloat _origDescHeight;
    AlertType _type;
}

-(void)awakeFromNib {
    self.descriptionLabel.textColor = [Helper sharedInstance].secondaryColor;
    self.backgroundView.backgroundColor = [Helper sharedInstance].mainColor;
    self.titleLabel.textColor = [Helper sharedInstance].secondaryColor;
    self.cancelButton.tintColor = [Helper sharedInstance].secondaryColor;
    self.okayButton.tintColor = [Helper sharedInstance].mainColor;
    self.okayButton.backgroundColor = [Helper sharedInstance].secondaryColor;
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _origFrame = self.backgroundView.frame;
    _hiddenFrame = CGRectMake(_origFrame.origin.x, -_origFrame.size.height, _origFrame.size.width, _origFrame.size.height);
    self.backgroundView.frame = _hiddenFrame;
    self.alpha = 0;
    self.backgroundFrameView.alpha = 0;
    _origDescHeight = self.descriptionLabel.frame.size.height;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dropAlertWithTitle:(NSString*)title withDescription:(NSString*)desctiption andType:(AlertType)type{
    _type = type;
    self.alpha = 1;
    self.titleLabel.text = title;
    self.descriptionLabel.text = desctiption;
    CGRect r = [desctiption boundingRectWithSize:CGSizeMake(200, 0)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                      context:nil];
    
    CGFloat diff = (r.size.height - _origDescHeight);
   
    _destFrame = CGRectMake(_origFrame.origin.x, _origFrame.origin.y - diff / 2 - 6, _origFrame.size.width, _origFrame.size.height + diff + 12);
    
    _hiddenFrame = CGRectMake(_origFrame.origin.x, -_destFrame.size.height, _origFrame.size.width, _destFrame.size.height);
    
    self.backgroundView.frame = _hiddenFrame;

    [self setNeedsDisplay];
    
    [UIView animateWithDuration:animDur animations:^{
        self.backgroundFrameView.alpha = 1;
        self.backgroundView.frame = _destFrame;
    }];
}

-(void)hideAlertView {
    [UIView animateWithDuration:animDur animations:^{
        self.backgroundView.frame = _hiddenFrame;
        self.backgroundFrameView.alpha = 0;
    } completion:^(BOOL finished) {
        self.alpha = 0;
    }];
}

- (IBAction)okButtonTouched:(id)sender {
    [self hideAlertView];
    if([self.delegate respondsToSelector:@selector(alertViewDidAccept:withType:)]){
        [self.delegate alertViewDidAccept:self withType:_type];
    }
}

- (IBAction)cancelButtonTouched:(id)sender {
    [self hideAlertView];
    if([self.delegate respondsToSelector:@selector(alertViewDidCancel:withType:)]){
        [self.delegate alertViewDidCancel:self withType:_type];
    }
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.okayButton.frame = CGRectMake(10, _hiddenFrame.size.height - 40 , 90, 30);
    self.cancelButton.frame = CGRectMake(100, _hiddenFrame.size.height - 40, 90, 30);
}

@end
