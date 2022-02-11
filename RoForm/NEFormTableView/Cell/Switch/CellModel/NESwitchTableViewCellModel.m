//
//  NESwitchTableViewCell.m
//  NETools
//
//  Created by roder on 2020/12/1.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NESwitchTableViewCellModel.h"
#import "NESwitchTableViewCell.h"

@implementation NESwitchTableViewCellModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.className = NSStringFromClass([NESwitchTableViewCell class]);
    }
    return self;
}
@end
