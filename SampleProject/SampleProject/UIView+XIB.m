//
//  UIView+XIB.m
//  Test
//
//  Created by Alex Bumbu on 17/02/15.
//  Copyright (c) 2015 Alex Bumbu. All rights reserved.
//

#import "UIView+XIB.h"

@implementation UIView (XIB)

+ (instancetype)initFromNib {
    return [self initWithNib:NSStringFromClass([self class]) bundle:nil];
}

+ (instancetype)initWithNib:(NSString *)nibName bundle:(NSBundle *)bundle {
    if (!bundle)
        bundle = [NSBundle mainBundle];
    
    NSArray *viewsArray = [bundle loadNibNamed:nibName owner:nil options:nil];
    if (!viewsArray.count) {
        NSLog(@"%@ - no nib found for name %@", NSStringFromClass([self class]), nibName);
        
        return nil;
    }
    
    for (id aView in viewsArray) {
        if ([aView isKindOfClass:[self class]])
            return aView;
    }
    
    return nil;
}

@end
