//
//  MainDataSourceController.m
//  SampleProject
//
//  Created by Alex Bumbu on 13/07/15.
//  Copyright (c) 2015 Alex Bumbu. All rights reserved.
//

#import "MainDataSourceController.h"
#import "ABMenuTableViewCell.h"

#import "MainViewController.h"
#import "ABCellMenuView.h"
#import "CustomMenuTableViewCell.h"


static NSString *menuCellIdentifier = @"Default Cell";
static NSString *customCellIdentifier = @"Custom Cell";

@interface MainDataSourceController () <ABCellMenuViewDelegate>

@end

@implementation MainDataSourceController {
    NSMutableArray *_dataSource;
}

@synthesize tableView = _tableView;
@synthesize viewController = _viewController;

- (void)refreshDataSourceWithCompletionHandler:(void (^)())completion {
    [self loadDataSource];
    
    if (completion)
        completion();
}

#pragma mark UITableViewDataSource Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0 * (self.menuPosition + 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ABMenuTableViewCell *cell = nil;
    
    switch (self.menuPosition) {
        case 0: {
            cell = [self menuCellAtIndexPath:indexPath];
            break;
        }
        case 1: {
            cell = [self customCellAtIndexPath:indexPath];
            break;
        }
            
        default:
            break;
    }

    // custom menu view
    NSString *nibName = (self.menuPosition == 0)? @"ABCellMailStyleMenuView" : @"ABCellCustomStyleMenuView";
    ABCellMenuView *menuView = [ABCellMenuView initWithNib:nibName bundle:nil];
    menuView.delegate = self;
    menuView.indexPath = indexPath;
    cell.rightMenuView = menuView;
        
    return cell;
}

- (ABMenuTableViewCell*)menuCellAtIndexPath:(NSIndexPath*)indexPath {
    ABMenuTableViewCell *cell = (ABMenuTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:menuCellIdentifier];
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.text = @"swipe to show custom menu";
    
    return cell;
}

//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}


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
    [self.tableView deleteRowsAtIndexPaths: @[menuView.indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    // make sure to reload in order to update the custom menu index path for each row
    NSMutableArray *rowsToReload = [NSMutableArray array];
    for (int i = 0; i < _dataSource.count - menuView.indexPath.row; i++) {
        [rowsToReload addObject:[NSIndexPath indexPathForRow:menuView.indexPath.row + i inSection:0]];
    }
    
    [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark Private Methods

- (void)loadDataSource {
    NSString *dataSourcePath = [[NSBundle mainBundle] pathForResource:@"DataSource" ofType:@"plist"];
    _dataSource = [[NSMutableArray alloc] initWithContentsOfFile:dataSourcePath];
}

- (NSInteger)menuPosition {
    return ((MainViewController *)self.viewController).segmentedControl.selectedSegmentIndex;
}

- (CustomMenuTableViewCell*)customCellAtIndexPath:(NSIndexPath*)indexPath {
    // prepare the attributed string
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[_dataSource objectAtIndex:indexPath.row]
                                                                                attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    NSAttributedString *detailsAttrStr = [[NSMutableAttributedString alloc] initWithString:@"\nswipe to show custom menu"
                                                                                attributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:11.0]}];
    [attrStr appendAttributedString:detailsAttrStr];
    
    // setup the cell
    CustomMenuTableViewCell *cell = (CustomMenuTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
    cell.mainLabel.attributedText = attrStr;
    
    return cell;
}

@end
