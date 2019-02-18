//
//  OBJCDetailViewController.m
//  AlertTableViewController
//
//  Created by Nayem on 2/18/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

#import "OBJCDetailViewController.h"

@interface OBJCDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation OBJCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textLabel.text = [NSString stringWithFormat:@"%@'s Detail Page", self.model.name];
}
- (IBAction)closeButtonDidTap:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
