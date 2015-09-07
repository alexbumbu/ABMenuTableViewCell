//
//  MainViewController.m
//  Test
//
//  Created by Alex Bumbu on 06/12/14.
//  Copyright (c) 2014 Alex Bumbu. All rights reserved.
//

#import "MainViewController.h"
#import "UITableView+DataSourceController.h"

#import "MainDataSourceController.h"


@interface MainViewController ()

@end

@implementation MainViewController {
    IBOutlet UITableView *listTableView;
}

@synthesize segmentedControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // setup data source controller - can also be setup from IB
    MainDataSourceController *dataSourceCtrl = [[MainDataSourceController alloc] init];
    dataSourceCtrl.tableView = listTableView;
    dataSourceCtrl.viewController = self;
    listTableView.dataSourceController = dataSourceCtrl;
    
    // load data source
    [listTableView.dataSourceController refreshDataSourceWithCompletionHandler:nil];
    
    self.navigationItem.titleView = segmentedControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Actions

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    [listTableView reloadData];
}

@end
