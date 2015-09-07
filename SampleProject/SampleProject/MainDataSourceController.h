//
//  MainDataSourceController.h
//  SampleProject
//
//  Created by Alex Bumbu on 13/07/15.
//  Copyright (c) 2015 Alex Bumbu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ABDataSourceController.h>


@interface MainDataSourceController : NSObject <ABDataSourceController>

@property (nonatomic, assign) IBOutlet UITableView *tableView;
@property (nonatomic, assign) IBOutlet UIViewController *viewController;

@end
