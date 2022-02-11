//
//  NEFillDetailTableViewCellModel.m
//  NETools
//
//  Created by roder on 2020/11/8.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFillDetailTableViewCellModel.h"
#import "NEFillDetailTableViewCell.h"

@implementation NEFillDetailTableViewCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.className = NSStringFromClass([NEFillDetailTableViewCell class]);
    }
    return self;
}

@end
