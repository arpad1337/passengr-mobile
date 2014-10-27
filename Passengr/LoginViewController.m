//
//  LoginViewController.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.23..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import "LoginViewController.h"
#import "SessionManager.h"
#import "Helper.h"

typedef NS_ENUM(NSUInteger, SelectionType) {
    kGender,
    kAge
};

#define animationDuration 0.2

@interface LoginViewController () {
    SelectorView* _sel;
    NSArray* _kGender;
    NSArray* _kAge;
    SelectionType _type;
    BOOL _isSelectionHidden;
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [Helper sharedInstance].mainColor;
    [self.setButton setTitleColor:[Helper sharedInstance].mainColor forState:UIControlStateNormal];
    [self.setButton setTitleColor:[Helper sharedInstance].mainColor forState:UIControlStateHighlighted];
    
    self.genderLabel.textColor = [Helper sharedInstance].mainColor;
    self.ageLabel.textColor = [Helper sharedInstance].mainColor;
    
    _kGender = [[NSArray alloc] initWithObjects:@"male", @"female", nil];
    NSMutableArray* t = [[NSMutableArray alloc] init];
    for (int i = 0; i < 87; i++) {
        [t addObject:[NSNumber numberWithInt:i + 13]];
    }
    _kAge = (NSArray*)t;
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"SelectorView"
                                                      owner:self
                                                    options:nil];
    _sel = (SelectorView*)[nibViews objectAtIndex:0];
    [_sel configureView];
    _sel.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    _isSelectionHidden = YES;
    
    _sel.delegate = self;
    
    [self.view addSubview:_sel];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectorTap:)];
    [self.genderSelectorView addGestureRecognizer:tap];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectorTap:)];
    [self.ageSelectorView addGestureRecognizer:tap];
    
    self.age = @23;
    self.gender = @"male";
}

#pragma mark SelectorViewDelegate

-(void)selectionDidChange:(id)value {
    [self toggleSelection];
    if(_type == kGender) {
        self.gender = value;
    } else {
        self.age = value;
    }
}

-(void)selectionDidCancel {
    [self toggleSelection];
}

-(void)toggleSelection {
    _isSelectionHidden = !_isSelectionHidden;
    if(_isSelectionHidden) {
        [UIView animateWithDuration:animationDuration animations:^{
            _sel.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    } else {
        [UIView animateWithDuration:animationDuration animations:^{
            _sel.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

#pragma mark Actions

-(void)selectorTap:(UITapGestureRecognizer*)r {
    
    if([r.view isEqual:self.genderSelectorView]) {
        _type = kGender;
        _sel.data = _kGender;
        _sel.titleLabel.text = @"Set your Gender";
        [self toggleSelection];
    } else {
        _type = kAge;
        _sel.data = _kAge;
        _sel.titleLabel.text = @"Set your Age";
        [self toggleSelection];
    }
}
- (IBAction)startSession:(id)sender {
    [SessionManager sharedInstance].gender = self.gender;
    [SessionManager sharedInstance].age = self.age;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark Setters

-(void)setAge:(NSNumber *)age {
    _age = age;
    self.ageLabel.text = [age stringValue];
}

-(void)setGender:(NSString *)gender {
    _gender = gender;
    self.genderLabel.text = gender;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
