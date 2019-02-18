//
//  OBJCHomeViewController.m
//  AlertTableViewController
//
//  Created by Nayem on 2/18/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

#import "OBJCHomeViewController.h"
#import "OBJCPopoverPicker.h"
#import "OBJCDetailViewController.h"

@interface OBJCHomeViewController ()
@property (nonatomic, strong) OBJCPopoverPicker *popoverPicker;
@end

@implementation OBJCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)popupButtonDidTap:(UIButton *)sender {
    NSArray<OBJCModel *> *models = @[ [[OBJCModel alloc] initWithName:@"Nayem" ID:1],
                                      [[OBJCModel alloc] initWithName:@"Hasib" ID:2],
                                      [[OBJCModel alloc] initWithName:@"Ashik" ID:3],
                                      [[OBJCModel alloc] initWithName:@"Azad" ID:4]
                                    ];
    __weak typeof(self) weakSelf = self;
    self.popoverPicker = [[OBJCPopoverPicker alloc] initWithTitle:@"Choose An Option" dismissButtonTitle:@"Cancel" models:models onSelect:^(OBJCModel * _Nonnull model) {
        [weakSelf performSegueWithIdentifier:@"OBJCDetailSegue" sender:model];
    }];
    [self.popoverPicker present];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"OBJCDetailSegue"]) {
        OBJCModel *model = (OBJCModel*)sender;
        if (model) {
            OBJCDetailViewController *detailViewController = [segue destinationViewController];
            detailViewController.model = model;
        }
    }
}


@end
