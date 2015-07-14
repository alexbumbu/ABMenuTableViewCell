//
//  UITableView+DataSourceController.m
//  ABDataSourceController
//
//  Created by Alex Bumbu on 10/07/15.
//  Copyright (c) 2015 Alex Bumbu. All rights reserved.
//

#import "UITableView+DataSourceController.h"
#import <objc/runtime.h>

@implementation UITableView (DataSourceController)

@dynamic dataSourceController;

- (void)setDataSourceController:(id<ABDataSourceController>)dataSourceController {
    objc_setAssociatedObject(self, @selector(dataSourceController), dataSourceController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.delegate = dataSourceController;
    self.dataSource = dataSourceController;
    
    dataSourceController.tableView = self;
}

- (id<ABDataSourceController>)dataSourceController {
    return objc_getAssociatedObject(self, @selector(dataSourceController));
}

@end
