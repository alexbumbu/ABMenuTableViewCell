//
//  ABTableViewCell.m
//  Test
//
//  Created by Alex Bumbu on 06/12/14.
//  Copyright (c) 2014 Alex Bumbu. All rights reserved.
//

#import "ABMenuTableViewCell.h"

@implementation ABMenuTableViewCell {
    CGRect _rightMenuViewInitialFrame;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
        panGesture.delegate = self;
        [self addGestureRecognizer:panGesture];
    }
    
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        // content view frame is different before moving to superview, so it's critical to get it right
        if (_rightMenuView) {
            _rightMenuView.frame = CGRectMake(CGRectGetWidth(self.contentView.frame), .0, .0, CGRectGetHeight(self.contentView.frame));
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    // enable only horizontal gesture
    CGPoint velocity = [panGestureRecognizer velocityInView:self];
    return fabs(velocity.x) > fabs(velocity.y);
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


#pragma mark Actions

- (void)swipeGesture:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGRect menuNewFrame;
        CGFloat initialWidth = CGRectGetWidth(_rightMenuViewInitialFrame);
        NSInteger direction;
        
        // find swipe direction
        CGPoint velocity = [gesture velocityInView:self];
        if (velocity.x > 0) {
            // towards right
            menuNewFrame = CGRectMake(CGRectGetWidth(self.contentView.frame), .0, .0, CGRectGetHeight(self.contentView.frame));
            direction = -1;
        }
        else {
            // towards left
            menuNewFrame = CGRectMake(CGRectGetWidth(self.contentView.frame) - initialWidth, .0, initialWidth, CGRectGetHeight(self.contentView.frame));
            direction = 1;
        }
        
        if (CGRectEqualToRect(menuNewFrame, _rightMenuView.frame))
            return;

        // animate showing menuView
        [UIView animateWithDuration:.26
                         animations:^{
                             _rightMenuView.frame = menuNewFrame;
                         }];
        
        for (UIView *subview in self.contentView.subviews) {
            if (subview == _rightMenuView)
                continue;
            
            [UIView animateWithDuration:.6
                                  delay:.0
                 usingSpringWithDamping:(direction > 0) ? .6 : 1.0
                  initialSpringVelocity:(direction > 0) ? 1.0 : .0
                                options:0
                             animations:^{
                                 subview.frame = CGRectMake(CGRectGetMinX(subview.frame) - direction*initialWidth, CGRectGetMinY(subview.frame), CGRectGetWidth(subview.frame), CGRectGetHeight(subview.frame));
                             }
                             completion:nil];
        }
    }
}

@end
