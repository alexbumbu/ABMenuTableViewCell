//
//  UITableView+DataSourceController.h
//  ABDataSourceController
//
//  Created by Alex Bumbu on 10/07/15.
//  Copyright (c) 2015 Alex Bumbu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABDataSourceController.h"

@interface UITableView (DataSourceController)

@property (nonatomic, strong) IBOutlet id<ABDataSourceController> dataSourceController;

@end
