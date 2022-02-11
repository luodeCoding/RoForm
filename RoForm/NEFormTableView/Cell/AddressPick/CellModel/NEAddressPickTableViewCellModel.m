//
//  NEAddressPickTableViewCellModel.m
//  NETools
//
//  Created by roder on 2020/11/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEAddressPickTableViewCellModel.h"
#import "NEAddressPickTableViewCell.h"

@implementation NEAddressPickTableViewCellModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.className = NSStringFromClass([NEAddressPickTableViewCell class]);
    }
    return self;
}

@end
