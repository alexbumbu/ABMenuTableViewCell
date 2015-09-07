//
//  ABDataSourceController.h
//  ABDataSourceController
//
//  Created by Alex Bumbu on 10/07/15.
//  Copyright (c) 2015 Alex Bumbu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ABDataSourceController <NSObject, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) IBOutlet UITableView *tableView;
@property (nonatomic, assign) IBOutlet UIViewController *viewController;

- (void)refreshDataSourceWithCompletionHandler:(void (^)())completion;

@end
