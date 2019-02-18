//
//  OBJCModel.m
//  AlertTableViewController
//
//  Created by Nayem on 2/18/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

#import "OBJCModel.h"

@implementation OBJCModel

- (instancetype)initWithName:(NSString *)name ID:(NSUInteger)ID {
    self = [super init];
    self.name = name;
    self.ID = ID;
    return self;
}

@end
