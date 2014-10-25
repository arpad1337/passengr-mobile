//
//  SelectorView.m
//  Passengr
//
//  Created by Árpád Kiss on 2014.07.24..
//  Copyright (c) 2014 Peabo Media Kft. All rights reserved.
//

#import "SelectorView.h"
#import "SelectionTableViewCell.h"
#import "Helper.h"

static NSString* kReuseIdent = @"SelectionReuseID";

@implementation SelectorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)configureView {
    self.backgroundColor = [Helper sharedInstance].mainColor;
    
    UINib* nib = [UINib nibWithNibName:@"SelectionTableViewCell" bundle:nil];
    
    [self.selectionTableView registerNib:nib forCellReuseIdentifier:kReuseIdent];
    [self.selectionTableView setSeparatorColor:[Helper sharedInstance].secondaryColor];
    self.titleLabel.textColor = [Helper sharedInstance].mainColor;
    self.selectionTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)setData:(NSArray*)values {
    _data = values;
    [self.selectionTableView reloadData];
}

- (IBAction)closeViewAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(selectionDidCancel)]) {
        [self.delegate selectionDidCancel];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectionTableViewCell* cell = [self.selectionTableView dequeueReusableCellWithIdentifier:kReuseIdent];
    id t = _data[indexPath.row];
    if([t isKindOfClass:[NSNumber class]]) {
        cell.selectionLabel.text = [t stringValue];
    } else {
        cell.selectionLabel.text = t;
    }
        
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(selectionDidChange:)]) {
        [self.delegate selectionDidChange:_data[indexPath.row]];
    }
    return YES;
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
