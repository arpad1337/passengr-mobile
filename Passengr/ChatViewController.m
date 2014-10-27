//
//  ChatViewController.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.25..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatLeftBubbleTableViewCell.h"
#import "ChatRightBubbleTableViewCell.h"
#import "ChatNotificationTableViewCell.h"
#import "MenuButton.h"
#import "SessionManager.h"
#import "Helper.h"
#import "Message.h"

#define animationDuration 0.2

@interface ChatViewController () {
    BOOL _isMenuHidden;
    NSArray* _messages;
    CGRect _lastInputContainerFrame;
    CGRect _lastTableViewFrame;
    NSArray* _menuButtons;
    AboutView* _aboutView;
    AlertView* _alertView;
    BOOL _isAboutHidden;
}

@end

static NSString* kLeftBubbleReuseIdent = @"ChatLeftBubbleReuseID";
static NSString* kRightBubbleReuseIdent = @"ChatRightBubbleReuseID";
static NSString* kNotificationReuseIdent = @"ChatNotificationReuseID";


@implementation ChatViewController

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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [Helper sharedInstance].mainColor;
    self.titleLabel.textColor = [Helper sharedInstance].mainColor;
    
    Message* message_1 = [[Message alloc] init];
    message_1.type = own;
    message_1.message = @"Partner connected.";
    message_1.date = [NSDate date];
    
    Message* message_2 = [[Message alloc] init];
    message_2.type = partner;
    message_2.message = @"HELLO😄";
    message_2.date = [NSDate date];
    
    Message* message_3 = [[Message alloc] init];
    message_3.type = notification;
    message_3.message = @"what.";
    message_3.date = [NSDate date];
    
    _messages = @[message_1, message_2, message_3];
    
    self.messageTextField.textColor = [Helper sharedInstance].secondaryColor;
    self.messageTextField.backgroundColor = [Helper sharedInstance].mainColor;
    
    UINib* nib = [UINib nibWithNibName:@"ChatLeftBubbleTableViewCell" bundle:nil];
    
    [self.messagesTableView registerNib:nib forCellReuseIdentifier:kLeftBubbleReuseIdent];
    
    nib = [UINib nibWithNibName:@"ChatRightBubbleTableViewCell" bundle:nil];

    [self.messagesTableView registerNib:nib forCellReuseIdentifier:kRightBubbleReuseIdent];
    
    nib = [UINib nibWithNibName:@"ChatNotificationTableViewCell" bundle:nil];
    
    [self.messagesTableView registerNib:nib forCellReuseIdentifier:kNotificationReuseIdent];
    
    self.messagesTableView.layoutMargins = UIEdgeInsetsZero;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    
    self.messagesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.messageTextField.layer.cornerRadius = 6.0f;
    self.messageTextField.layer.borderWidth = 1.0f;
    self.messageTextField.layer.borderColor = [Helper sharedInstance].mainColor.CGColor;
    
    self.messageTextField.delegate = self;

    [self setUpMenu];
    [self setUpAboutView];
    [self setUpAlertView];
}

#pragma mark Menu 
-(void)setUpMenu {
    [self.toggleMenuButton setImage:[UIImage imageNamed:@"menuOpen.png"] forState:UIControlStateNormal];
    [self.toggleMenuButton setImage:[UIImage imageNamed:@"menuClose.png"] forState:UIControlStateSelected];
    
    _isMenuHidden = YES;
    
    NSMutableArray* tmp = [[NSMutableArray alloc] init];
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"MenuButton"
                                                      owner:self
                                                    options:nil];
    
    MenuButton* about = (MenuButton*)[nibViews objectAtIndex:0];
    about.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    [about configureButton:[UIImage imageNamed:@"menuAbout"] withTitle:@"About this app"];
    
    [self.view addSubview:about];
    
    [about addTarget:self action:@selector(toggleAboutView:) forControlEvents:UIControlEventTouchUpInside];
    [about addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    [tmp addObject:about];
    
    nibViews = [[NSBundle mainBundle] loadNibNamed:@"MenuButton"
                                             owner:self
                                           options:nil];
    
    MenuButton* change = (MenuButton*)[nibViews objectAtIndex:0];
    change.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    [change configureButton:[UIImage imageNamed:@"menuChange"] withTitle:@"Change details"];
    [self.view addSubview:change];
    
    [change addTarget:self action:@selector(dropChangeDetailsConfirmation) forControlEvents:UIControlEventTouchUpInside];
    [change addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    [tmp addObject:change];
    
    nibViews = [[NSBundle mainBundle] loadNibNamed:@"MenuButton"
                                             owner:self
                                           options:nil];
    
    MenuButton* report = (MenuButton*)[nibViews objectAtIndex:0];
    report.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    [report configureButton:[UIImage imageNamed:@"menuReport"] withTitle:@"Report user"];
    [self.view addSubview:report];
    
    [report addTarget:self action:@selector(dropUserReportConfirmation) forControlEvents:UIControlEventTouchUpInside];
    [report addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    [tmp addObject:report];
    
    _menuButtons = (NSArray*)tmp;
    [self.view bringSubviewToFront:self.headerContainerView];
}

-(void)hideKeyboard {
    [self.messageTextField resignFirstResponder];
}

-(IBAction)toggleMenu:(UIButton*)button {
    button.selected = !button.selected;
    if(_isMenuHidden) {
        __block float delay = 0.15;
        [_menuButtons enumerateObjectsUsingBlock:^(MenuButton* button, NSUInteger idx, BOOL *stop) {
            [UIView animateWithDuration:0.15 delay:delay options:(6<<16) animations:^{
                //
                button.frame = CGRectMake(0, (3-idx) * 60, button.frame.size.width, button.frame.size.height);
            } completion:^(BOOL finished) {
                //
            }];
            delay = delay - 0.05;
        }];
    } else {
        __block float delay = 0.0;
        [_menuButtons enumerateObjectsUsingBlock:^(MenuButton* button, NSUInteger idx, BOOL *stop) {
            [UIView animateWithDuration:0.15 delay:delay options:(6<<16) animations:^{
                //
                button.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
            } completion:^(BOOL finished) {
                //
            }];
            delay = delay + 0.05;
        }];
    }
    _isMenuHidden = !_isMenuHidden;
}

-(void)menuSelected:(id)sender {
    
}

#pragma mark Actions

- (IBAction)nextUser:(UIButton*)sender {
    
}

- (IBAction)openCapture:(UIButton*)sender {
    
}

- (IBAction)sendMessage:(UIButton*)sender {
    NSString* message = [self.messageTextField.text copy];
    message = [message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(message.length > 0) {
        NSMutableArray* t = [_messages mutableCopy];
        
        Message* newMessage = [[Message alloc] init];
        newMessage.type = own;
        newMessage.message = message;
        newMessage.date = [NSDate date];
        [t addObject:newMessage];
        self.messageTextField.text = @"";
        _messages = (NSArray*)t;
        NSIndexPath* newPath = [NSIndexPath indexPathForRow:_messages.count - 1 inSection:0];
        [self.messagesTableView insertRowsAtIndexPaths:@[newPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.messagesTableView scrollToRowAtIndexPath:newPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messages.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message* message = _messages[indexPath.row];
    ChatTableViewCell* cell;
    switch (message.type) {
        case own:
            cell = [self.messagesTableView dequeueReusableCellWithIdentifier:kRightBubbleReuseIdent];
            break;
        case notification:
            cell = [self.messagesTableView dequeueReusableCellWithIdentifier:kNotificationReuseIdent];
            break;
        case partner:
            cell = [self.messagesTableView dequeueReusableCellWithIdentifier:kLeftBubbleReuseIdent];
            break;
    }
    cell.message = message;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message* message = _messages[indexPath.row];
    if(message.type == notification) {
        return 44;
    }
    CGRect r = [message.message boundingRectWithSize:CGSizeMake(202, 0)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                      context:nil];
    return 70 - 26 + r.size.height;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(!_isMenuHidden) {
        [self toggleMenu:self.toggleMenuButton];
    }
    [self.messageTextField resignFirstResponder];
}

#pragma mark Keyboard patch 
- (void)keyboardWillShowOrHide:(NSNotification *)notification {
    if(!_isMenuHidden) {
        [self toggleMenu:self.toggleMenuButton];
    }
    
    CGRect keyboardFrameEnd = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardFrameEndInMessagesTableView = [self.messagesTableView convertRect:keyboardFrameEnd fromView:nil];
    CGRect keyboardFrameEndInInputContainerView = [self.inputContainerView convertRect:keyboardFrameEnd fromView:nil];
    
    [self.messagesTableView setNeedsUpdateConstraints];
    [self.inputContainerView setNeedsUpdateConstraints];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.messagesTableView.frame = CGRectMake(self.messagesTableView.frame.origin.x, self.messagesTableView.frame.origin.y, self.messagesTableView.frame.size.width, keyboardFrameEndInMessagesTableView.origin.y - 60 - self.messagesTableView.bounds.origin.y);
    if(_messages.count > 0) {
        [self.messagesTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow: _messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    _lastTableViewFrame = self.messagesTableView.frame;
    
    NSLog(@"%@", NSStringFromCGRect(self.inputContainerView.frame ));
    
    self.inputContainerView.frame = CGRectMake(self.inputContainerView.frame.origin.x, self.inputContainerView.frame.origin.y + keyboardFrameEndInInputContainerView.origin.y - 60, self.inputContainerView.frame.size.width, self.inputContainerView.frame.size.height);
   
    NSLog(@"%@", NSStringFromCGRect(self.inputContainerView.frame ));
    
    _lastInputContainerFrame = self.inputContainerView.frame;
    
    [self.inputContainerView layoutIfNeeded];
    [self.messagesTableView layoutIfNeeded];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(constraintPatch)];
    [UIView commitAnimations];
}

-(void)constraintPatch {
    [self.view layoutSubviews];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    // fix frames
    //self.inputContainerView.frame = _lastInputContainerFrame;
    //self.messagesTableView.frame = _lastTableViewFrame;
    [self sendMessage:nil];
    return YES;
}

- (IBAction)textfieldValueChanged:(UITextField*)sender {
    [UIView animateWithDuration:0.1 animations:^{
        [sender sizeToFit];
    }];
}

#pragma mark Change details 
-(void)changeDetails {
    [SessionManager sharedInstance].gender = nil;
    [SessionManager sharedInstance].age = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Report User
-(void)reportUser {
    
}

#pragma mark AboutView
-(void)setUpAboutView {
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"AboutView"
                                                      owner:self
                                                    options:nil];
    _aboutView = (AboutView*)[nibViews objectAtIndex:0];
    _aboutView.delegate = self;
    _aboutView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    [_aboutView setNeedsDisplay];
    [self.view addSubview:_aboutView];
}

-(void)toggleAboutView:(MenuButton*)button {
    if(!_isMenuHidden) {
        [self toggleMenu:self.toggleMenuButton];
    }
    if(_isAboutHidden) {
        [UIView animateWithDuration:animationDuration delay:0 options:(6<<16) animations:^{
            //
            _aboutView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            //
        }];
    } else {
        [UIView animateWithDuration:animationDuration delay:0 options:(6<<16) animations:^{
            //
            _aboutView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            //
        }];
    }
    _isAboutHidden = !_isAboutHidden;
}

-(void)closeButtonPressed {
    [self toggleAboutView:nil];
}

#pragma mark AlertView

-(void)setUpAlertView {
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"AlertView"
                                                      owner:self
                                                    options:nil];
    _alertView = (AlertView*)[nibViews objectAtIndex:0];
    _alertView.delegate = self;
    [self.view addSubview:_alertView];
}

-(void)dropUserReportConfirmation {
    [self toggleMenu:self.toggleMenuButton];
    [_alertView dropAlertWithTitle:@"Report user" withDescription:@"Are you sure you want to report this user?" andType:kReport];
}

-(void)dropChangeDetailsConfirmation {
    [self toggleMenu:self.toggleMenuButton];
    [_alertView dropAlertWithTitle:@"Change details" withDescription:@"Are you sure you want to change your details and interrupt this session?" andType:kChangeDetails];
}

-(void)alertViewDidAccept:(AlertView *)alertView withType:(AlertType)type{
    switch (type) {
        case kReport:
            [self reportUser];
            break;
        case kChangeDetails:
            [self changeDetails];
            break;
        default:
            break;
    }
}

-(void)alertViewDidCancel:(AlertView *)alertView withType:(AlertType)type{
    switch (type) {
        case kReport:
            
            break;
            
        default:
            break;
    }
}

#pragma mark Stuff

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
