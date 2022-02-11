//
//  NESingleButtonTableViewCellModel.m
//  NETools
//
//  Created by roder on 2020/11/8.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NESingleButtonTableViewCellModel.h"
#import "NESingleButtonTableViewCell.h"

@implementation NESingleButtonTableViewCellModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.className = NSStringFromClass([NESingleButtonTableViewCell class]);
    }
    return self;
}

@end
