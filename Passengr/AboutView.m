//
//  AboutView.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.08.06..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import <Social/Social.h>
#import "AboutView.h"
#import "Helper.h"

@implementation AboutView

-(void)awakeFromNib {
    [self setUpGestures];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)closeLayer:(id)sender {
    if([self.delegate respondsToSelector:@selector(closeButtonPressed)]) {
        [self.delegate closeButtonPressed];
    }
}

-(void)setUpGestures {
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openWebsite:)];
    [self.labels[self.labels.count -1] addGestureRecognizer:tap];
    [self.labels[self.labels.count -1] setUserInteractionEnabled:YES];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openTwitterShareDialog:)];
    
    [self.buttonBackgroundView addGestureRecognizer:tap];
}

-(void)openWebsite:(UILabel*)label {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.arpi.im/?from=passengr-app"]];
}

-(void)openTwitterShareDialog:(UIView*)fakeButtonView {
    SLComposeViewController *sharingSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    NSString *message = NSLocalizedString(@"Come and chat with me on Passengr! Instant fun! #passengr", nil);
    [sharingSheet setInitialText:[NSString stringWithFormat:@"%@ %@", message, @"http://passengr.me/appstore-download"]];
    [self.delegate presentViewController:sharingSheet animated:YES completion:Nil];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.labels enumerateObjectsUsingBlock:^(UILabel* obj, NSUInteger idx, BOOL *stop) {
        [obj setTextColor:[Helper sharedInstance].mainColor];
    }];
    
    UIImage* source = self.logoImageView.image;
    
    UIGraphicsBeginImageContextWithOptions(source.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[Helper sharedInstance].mainColor setFill];
    
    CGContextTranslateCTM(context, 0, source.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect srect = CGRectMake(0, 0, source.size.width, source.size.height);
    CGContextDrawImage(context, srect, source.CGImage);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextAddRect(context, srect);
    CGContextDrawPath(context,kCGPathFill);

    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.logoImageView setImage:coloredImg];
    self.buttonBackgroundView.backgroundColor = [Helper sharedInstance].mainColor;
    self.shareButtonLabel.textColor = [Helper sharedInstance].secondaryColor;
}


@end
