//
//  UITableView+VisibleMenuCell.m
//  SampleProject
//
//  Created by Alex Bumbu on 19/11/15.
//  Copyright © 2015 Alex Bumbu. All rights reserved.
//

#import "UITableView+VisibleMenuCell.h"
#import <objc/objc-runtime.h>

@implementation UITableView (VisibleMenuCell)

@dynamic visibleMenuCell;

- (void)setVisibleMenuCell:(ABMenuTableViewCell *)visibleMenuCell {
    objc_setAssociatedObject(self, @selector(visibleMenuCell), visibleMenuCell, OBJC_ASSOCIATION_ASSIGN);
}

- (ABMenuTableViewCell *)visibleMenuCell {
    return objc_getAssociatedObject(self, @selector(visibleMenuCell));
}

@end
