//
//  ABCellMenuView.m
//  Test
//
//  Created by Alex Bumbu on 17/02/15.
//  Copyright (c) 2015 Alex Bumbu. All rights reserved.
//

#import "ABCellMenuView.h"

@implementation ABCellMenuView {
    IBOutlet UIButton *deleteButton;
    IBOutlet UIButton *flagButton;
    IBOutlet UIButton *moreBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


#pragma mark Actions

- (IBAction)deleteBtnPressed:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cellMenuViewDeleteBtnTapped:)])
        [_delegate cellMenuViewDeleteBtnTapped:self];
}

- (IBAction)moreBtnPressed:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cellMenuViewMoreBtnTapped:)])
        [_delegate cellMenuViewMoreBtnTapped:self];
}

- (IBAction)flagBtnPressed:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cellMenuViewFlagBtnTapped:)])
        [_delegate cellMenuViewFlagBtnTapped:self];
}

@end
