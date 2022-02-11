//
//  NEPlainTextTableViewCellModel.m
//  NETools
//
//  Created by roder on 2020/12/21.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEPlainTextTableViewCellModel.h"
#import "NEPlainTextTableViewCell.h"
@implementation NEPlainTextTableViewCellModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.className = NSStringFromClass([NEPlainTextTableViewCell class]);
    }
    return self;
}
@end
