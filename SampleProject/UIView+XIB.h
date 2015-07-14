//
//  UIView+XIB.h
//  Test
//
//  Created by Alex Bumbu on 17/02/15.
//  Copyright (c) 2015 Alex Bumbu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XIB)

+ (instancetype)initFromNib;
+ (instancetype)initWithNib:(NSString *)nibName bundle:(NSBundle *)bundle;

@end
