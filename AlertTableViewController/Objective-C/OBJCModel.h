//
//  OBJCModel.h
//  AlertTableViewController
//
//  Created by Nayem on 2/18/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OBJCModel : NSObject

@property (strong) NSString *name;
@property NSUInteger ID;

- (instancetype)initWithName:(NSString *)name ID:(NSUInteger)ID;

@end

NS_ASSUME_NONNULL_END
