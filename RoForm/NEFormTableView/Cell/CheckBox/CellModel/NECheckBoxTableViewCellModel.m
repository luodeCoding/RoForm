//
//  NECheckBoxTableViewCellModel.m
//  NETools
//
//  Created by roder on 2020/12/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NECheckBoxTableViewCellModel.h"
#import "NECheckBoxTableViewCell.h"

@implementation NECheckBoxTableViewCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.className = NSStringFromClass([NECheckBoxTableViewCell class]);
        self.seletSub = [RACSubject subject];
    }
    return self;
}

@end
