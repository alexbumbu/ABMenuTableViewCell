//
//  ABCellMenuView.h
//  Test
//
//  Created by Alex Bumbu on 17/02/15.
//  Copyright (c) 2015 Alex Bumbu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+XIB.h"

@protocol ABCellMenuViewDelegate;

@interface ABCellMenuView : UIView

@property (nonatomic, assign) id<ABCellMenuViewDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end


@protocol ABCellMenuViewDelegate <NSObject>

@optional
- (void)cellMenuViewMoreBtnTapped:(ABCellMenuView *)menuView;
- (void)cellMenuViewFlagBtnTapped:(ABCellMenuView *)menuView;
- (void)cellMenuViewDeleteBtnTapped:(ABCellMenuView *)menuView;

@end
