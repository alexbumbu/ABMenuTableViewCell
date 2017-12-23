//
//  DetailsViewController.m
//  SampleProject
//
//  Created by Alex Bumbu on 23/12/2017.
//  Copyright © 2017 Alex Bumbu. All rights reserved.
//

#import "DetailsViewController.h"

NSString * const showDetailsSegueIdentifier = @"showDetails";

@implementation DetailsViewController {
    IBOutlet UILabel *messageLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    if ([self.itemName isEqualToString:@"Grim Fandango"]) {
        [self showSuccessMessage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Private Methods

- (void)showSuccessMessage {
    messageLabel.text = @"This is the one! Congrats, you've found it!";
}

@end
