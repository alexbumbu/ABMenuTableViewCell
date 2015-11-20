//
//  UITableView+MenuCell.m
//  SampleProject
//
//  Created by Alex Bumbu on 19/11/15.
//  Copyright © 2015 Alex Bumbu. All rights reserved.
//

#import "UITableView+MenuCell.h"
#import <objc/objc-runtime.h>

@implementation UITableView (MenuCell)

@dynamic visibleMenuCell;

- (void)setVisibleMenuCell:(ABMenuTableViewCell *)visibleMenuCell {
    objc_setAssociatedObject(self, @selector(visibleMenuCell), visibleMenuCell, OBJC_ASSOCIATION_ASSIGN);
}

- (ABMenuTableViewCell *)visibleMenuCell {
    return objc_getAssociatedObject(self, @selector(visibleMenuCell));
}

@end
