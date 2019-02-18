//
//  OBJCPopoverPicker.h
//  AlertTableViewController
//
//  Created by Nayem on 2/18/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OBJCModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^SelectionHandler) (OBJCModel *model);

@interface OBJCPopoverPicker : NSObject

- (instancetype)initWithTitle:(NSString *)title dismissButtonTitle:(NSString *)dismissButtonTitle models:(NSArray<OBJCModel *> *)models onSelect:(SelectionHandler)onSelect;

- (void)present;

@end

NS_ASSUME_NONNULL_END
