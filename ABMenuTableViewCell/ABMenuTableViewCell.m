//
//  ABTableViewCell.m
//  Test
//
//  Created by Alex Bumbu on 06/12/14.
//  Copyright (c) 2014 Alex Bumbu. All rights reserved.
//

#import "ABMenuTableViewCell.h"


typedef NS_ENUM(NSInteger, ABMenuUpdateAction) {
    ABMenuUpdateShowAction = 1,
    ABMenuUpdateHideAction = -1
};


static CGFloat kAnimationDuration = .6;

@interface ABMenuTableViewCell ()

@property (nonatomic, assign) UITableView *parentTableView;
@property (nonatomic, assign) BOOL ongoingTransition;

@end


@implementation ABMenuTableViewCell {
    CGRect _rightMenuViewInitialFrame;
    UIPanGestureRecognizer *_swipeGesture;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit]; 
    }
    
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        // content view frame is different before moving to superview, so it's critical to get it right
        if (_rightMenuView) {
            _rightMenuView.frame = CGRectMake(CGRectGetWidth(self.contentView.frame), .0, .0, CGRectGetHeight(self.contentView.frame));
        }
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    // find out the table view
    UIView *view = self.superview;
    
    while (view && [view isKindOfClass:[UITableView class]] == NO) {
        view = view.superview;
    }
    
    self.parentTableView = (UITableView *)view;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Configure the view for the selected state
    if (CGRectGetWidth(_rightMenuView.frame) > 0) {
        [self updateMenuView:ABMenuUpdateHideAction animated:YES];
        return;
    }
    
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    // workaround - handle the case with setHighlighted:animated: triggered on iPAD due
    //to stopping default gestures to run simultaneously with _swipeGesture
    if (self.ongoingTransition)
        return;
    
    if (CGRectGetWidth(_rightMenuView.frame) > 0) {
        [self updateMenuView:ABMenuUpdateHideAction animated:YES];
    }
    
    [super setHighlighted:highlighted animated:animated];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.rightMenuView = nil;
}

- (void)setRightMenuView:(UIView *)rightMenuView {
    if (_rightMenuView != rightMenuView) {
        // clean
        [_rightMenuView removeFromSuperview];
        
        // add new
        _rightMenuView = rightMenuView;
        _rightMenuViewInitialFrame = _rightMenuView.frame;
        _rightMenuView.frame = CGRectMake(CGRectGetWidth(self.contentView.frame), .0, .0, CGRectGetHeight(self.contentView.frame));
        [self.contentView addSubview:_rightMenuView];
    }
}


#pragma mark UIGestureRecognizerDelegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == _swipeGesture) {
        // enable only horizontal gesture
        CGPoint velocity = [(UIPanGestureRecognizer*)gestureRecognizer velocityInView:self];
        BOOL shouldBegin = fabs(velocity.x) > fabs(velocity.y);
        
        self.ongoingTransition = YES;
        
        return shouldBegin;
    }
    
    return YES;
}


#pragma mark Actions

- (void)handleSwipeGesture:(UIPanGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            NSInteger direction;
            
            // find swipe direction
            CGPoint velocity = [gesture velocityInView:self];
            if (velocity.x > 0) {
                // towards right - hide menu view
                direction = ABMenuUpdateHideAction;
            }
            else {
                // towards left - show menu view
                direction = ABMenuUpdateShowAction;
            }
            
            [self updateMenuView:direction animated:YES];
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            break;
        }
        case UIGestureRecognizerStateEnded: {
            self.ongoingTransition = NO;
            
            break;
        }
            
        default:
            break;
    }
}


#pragma mark Private Methods

- (void)commonInit {
    _swipeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    _swipeGesture.delegate = self;
    [self addGestureRecognizer:_swipeGesture];
}

- (void)updateMenuView:(ABMenuUpdateAction)action animated:(BOOL)animated {
    CGRect menuNewFrame;
    CGFloat initialWidth = CGRectGetWidth(_rightMenuViewInitialFrame);
    
    switch (action) {
        case ABMenuUpdateShowAction:
            menuNewFrame = CGRectMake(CGRectGetWidth(self.contentView.frame) - initialWidth, .0, initialWidth, CGRectGetHeight(self.contentView.frame));
            break;
        case ABMenuUpdateHideAction:
            menuNewFrame = CGRectMake(CGRectGetWidth(self.contentView.frame), .0, .0, CGRectGetHeight(self.contentView.frame));
            break;
            
        default:
            break;
    }
    
    if (CGRectGetWidth(menuNewFrame) == CGRectGetWidth(_rightMenuView.frame))
        return;
    
    // animate showing menuView
    [UIView animateWithDuration:(animated? .26 : .0)
                     animations:^{
                         _rightMenuView.frame = menuNewFrame;
                     }];
    
    for (UIView *subview in self.contentView.subviews) {
        if (subview == _rightMenuView)
            continue;
        
        [UIView animateWithDuration:(animated? kAnimationDuration : .0)
                              delay:.0
             usingSpringWithDamping:(action > 0) ? kAnimationDuration : 1.0
              initialSpringVelocity:(action > 0) ? 1.0 : .0
                            options:0
                         animations:^{
                             subview.frame = CGRectMake(CGRectGetMinX(subview.frame) - action*initialWidth, CGRectGetMinY(subview.frame), CGRectGetWidth(subview.frame), CGRectGetHeight(subview.frame));
                         }
                         completion:nil];
    }
}

@end
