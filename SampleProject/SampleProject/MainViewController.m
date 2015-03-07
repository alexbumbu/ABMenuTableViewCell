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
    
    // load data source
    [self loadDataSource];
    
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
    static NSString *identifier = @"ABMenuTableViewCell";
    
    ABMenuTableViewCell *cell = (ABMenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ABMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.text = @"swipe to show custom menu";
    
    // custom menu view
    NSString *nibName = (segmentedControl.selectedSegmentIndex == 0)? @"ABCellMailStyleMenuView" : @"ABCellCustomStyleMenuView";
    ABCellMenuView *menuView = [ABCellMenuView initWithNib:nibName bundle:nil];
    menuView.delegate = self;
    menuView.indexPath = indexPath;
    cell.rightMenuView = menuView;
    
    return cell;
}


#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
}


#pragma mark ABCellMenuViewDelegate Methods

- (void)cellMenuViewFlagBtnTapped:(ABCellMenuView *)menuView {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:[NSString stringWithFormat:@"Flag button pressed at position %@", @(menuView.indexPath.row)]
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)cellMenuViewMoreBtnTapped:(ABCellMenuView *)menuView {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:[NSString stringWithFormat:@"More button pressed at position %@", @(menuView.indexPath.row)]
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)cellMenuViewDeleteBtnTapped:(ABCellMenuView *)menuView {
    // update data source
    [_dataSource removeObjectAtIndex:menuView.indexPath.row];
    
    // update UI
    [listTableView deleteRowsAtIndexPaths: @[menuView.indexPath] withRowAnimation:UITableViewRowAnimationLeft];

    // make sure to reload in order to update the custom menu index path for each row
    NSMutableArray *rowsToReload = [NSMutableArray array];
    for (int i = 0; i < _dataSource.count - menuView.indexPath.row; i++) {
        [rowsToReload addObject:[NSIndexPath indexPathForRow:menuView.indexPath.row + i inSection:0]];
    }
    
    [listTableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark Actions

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    [listTableView reloadData];
}


#pragma mark Private Methods

- (void)loadDataSource {
    NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"DataSource" ofType:@"plist"];
    _dataSource = [[NSMutableArray alloc] initWithContentsOfFile:dataSourcePath];
}

@end
