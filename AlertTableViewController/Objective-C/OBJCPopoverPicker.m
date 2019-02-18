//
//  OBJCPopoverPicker.m
//  AlertTableViewController
//
//  Created by Nayem on 2/18/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

@import SDCAlertView;
#import "OBJCPopoverPicker.h"
#import "OBJCPopoverPickerTableViewCell.h"

@interface OBJCPopoverPicker () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SDCAlertController *alertController;
@property (nonatomic, strong) UITableView *tableView;

@property (strong) NSString *title;
@property (strong) NSString *dismissButtonTitle;
@property (strong) NSArray<OBJCModel *> *models;
@property (strong) SelectionHandler onSelect;

@end

static const CGFloat tableViewCellHeight = 135.0f/3.0f;

@implementation OBJCPopoverPicker

- (instancetype)initWithTitle:(NSString *)title dismissButtonTitle:(NSString *)dismissButtonTitle models:(NSArray<OBJCModel *> *)models onSelect:(nonnull SelectionHandler)onSelect {
    
    self = [super init];
    self.title = title;
    self.dismissButtonTitle = dismissButtonTitle;
    self.models = models;
    self.onSelect = onSelect;
    [self setupTableView];
    [self setupAlertController];
    return self;
    
}

- (void)present {
    [self.alertController presentAnimated:YES completion:nil];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"OBJCPopoverPickerTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = tableViewCellHeight;
    self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (void)setupAlertController {
    NSDictionary<NSAttributedStringKey, id> *attributes = @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                                             NSFontAttributeName: [UIFont systemFontOfSize:16]
                                                            };
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:self.title attributes:attributes];
    self.alertController = [[SDCAlertController alloc] initWithAttributedTitle:attributedTitle attributedMessage:nil preferredStyle:SDCAlertControllerStyleAlert];
    SDCAlertAction *dismissAction = [[SDCAlertAction alloc] initWithTitle:self.dismissButtonTitle style:SDCAlertActionStyleNormal handler:^(SDCAlertAction * action) {
        
    }];
    [self.alertController addAction:dismissAction];
    
    // Custom content view
    UIView *separatorAboveTableView = [UIView new];
    separatorAboveTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.alertController.contentView addSubview:separatorAboveTableView];
    
    [[separatorAboveTableView.leadingAnchor constraintEqualToAnchor:self.alertController.contentView.leadingAnchor] setActive:YES];
    [[separatorAboveTableView.trailingAnchor constraintEqualToAnchor:self.alertController.contentView.trailingAnchor] setActive:YES];
    [[separatorAboveTableView.topAnchor constraintEqualToAnchor:self.alertController.contentView.topAnchor] setActive:YES];
    [[separatorAboveTableView.heightAnchor constraintEqualToConstant:0.5f] setActive:YES];
    
    separatorAboveTableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.alertController.contentView addSubview:self.tableView];
    NSUInteger maximumNumberOfCellToBeVisible = 3;
    NSUInteger numberOfVisibleCell = [self.models count] < maximumNumberOfCellToBeVisible ? self.models.count : maximumNumberOfCellToBeVisible;
    CGFloat tableViewMaxHeight = tableViewCellHeight * numberOfVisibleCell;
    
    [[self.tableView.leadingAnchor constraintEqualToAnchor:self.alertController.contentView.leadingAnchor] setActive:YES];
    [[self.tableView.trailingAnchor constraintEqualToAnchor:self.alertController.contentView.trailingAnchor] setActive:YES];
    [[self.tableView.topAnchor constraintEqualToAnchor:separatorAboveTableView.bottomAnchor] setActive:YES];
    [[self.tableView.bottomAnchor constraintEqualToAnchor:self.alertController.contentView.bottomAnchor] setActive:YES];
    [[self.tableView.heightAnchor constraintEqualToConstant:tableViewMaxHeight] setActive:YES];
    
    // Appearance
    SDCAlertVisualStyle *visualStyle = [[SDCAlertVisualStyle alloc] initWithAlertStyle:SDCAlertControllerStyleAlert];
    visualStyle.backgroundColor = [UIColor blackColor];
    visualStyle.normalTextColor = [UIColor whiteColor];
    visualStyle.verticalElementSpacing = (visualStyle.verticalElementSpacing * 47) / 80;
    visualStyle.contentPadding = UIEdgeInsetsMake(32, 0, 0, 0);
    self.alertController.visualStyle = visualStyle;
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    OBJCPopoverPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    OBJCModel *model = self.models[indexPath.row];
    cell.titleLabel.text = model.name;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    [self.alertController dismissViewControllerAnimated:YES completion:^{
        OBJCModel *model = weakSelf.models[indexPath.row];
        if (weakSelf.onSelect) {
            weakSelf.onSelect(model);
        }
    }];
}

@end
