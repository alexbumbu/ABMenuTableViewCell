//
//  MainViewController.m
//  Test
//
//  Created by Alex Bumbu on 06/12/14.
//  Copyright (c) 2014 Alex Bumbu. All rights reserved.
//

#import "MainViewController.h"
#import "ABMenuTableViewCell.h"
#import "ABCellMenuView.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, ABCellMenuViewDelegate>

@end

@implementation MainViewController {
    IBOutlet UISegmentedControl *segmentedControl;
    IBOutlet UITableView *listTableView;
    
    NSMutableArray *_dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    // build data source
    _dataSource = [[NSMutableArray alloc] initWithCapacity:20];
    for (int i = 0; i < 20; i++) {
        [_dataSource addObject:[NSString stringWithFormat:@"Lorem ipsum dolor sit amet %@", @(i + 1)]];
    }
    
    self.navigationItem.titleView = segmentedControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0 * (segmentedControl.selectedSegmentIndex + 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    ABMenuTableViewCell *cell = (ABMenuTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ABMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        // add menu view
        ABCellMenuView *menuView = [ABCellMenuView initWithNib:(segmentedControl.selectedSegmentIndex == 0? @"ABCellMenuView" : @"ABCellMenuView2") bundle:nil];
        menuView.delegate = self;
        cell.rightMenuView = menuView;
    }
    
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    ((ABCellMenuView*)cell.rightMenuView).indexPath = indexPath;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


#pragma mark ABCellMenuViewDelegate Methods

- (void)cellMenuViewEditBtnTapped:(ABCellMenuView *)menuView {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[NSString stringWithFormat:@"Edit button pressed at position %@", @(menuView.indexPath.row)]
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)cellMenuViewDeleteBtnTapped:(ABCellMenuView *)menuView {
    // update data source
    [_dataSource removeObjectAtIndex:menuView.indexPath.row];

    // update UI
    ABMenuTableViewCell *cell = (ABMenuTableViewCell*)[listTableView cellForRowAtIndexPath:menuView.indexPath];
    cell.rightMenuView = nil;
    
    [listTableView deleteRowsAtIndexPaths: @[menuView.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [listTableView reloadData];
}


#pragma mark Actions

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    [listTableView reloadData];
}

@end
