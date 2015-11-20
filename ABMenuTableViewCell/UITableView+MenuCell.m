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

@dynamic shownMenuCell;

- (void)setShownMenuCell:(ABMenuTableViewCell *)shownMenuCell{
    objc_setAssociatedObject(self, @selector(shownMenuCell), shownMenuCell, OBJC_ASSOCIATION_ASSIGN);
}

- (ABMenuTableViewCell *)shownMenuCell {
    return objc_getAssociatedObject(self, @selector(shownMenuCell));
}

@end
