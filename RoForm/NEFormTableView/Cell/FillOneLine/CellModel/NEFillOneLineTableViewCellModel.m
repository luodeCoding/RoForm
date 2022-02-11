//
//  NEFillOneLineTableViewCellModel.m
//  NETools
//
//  Created by roder on 2020/11/6.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFillOneLineTableViewCellModel.h"
#import "NEFillOneLineTableViewCell.h"

@implementation NEFillOneLineTableViewCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.className = NSStringFromClass([NEFillOneLineTableViewCell class]);
    }
    return self;
}
@end
