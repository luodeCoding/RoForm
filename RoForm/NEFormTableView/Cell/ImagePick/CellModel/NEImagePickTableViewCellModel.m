//
//  NEImagePickTableViewCellModel.m
//  NETools
//
//  Created by roder on 2020/11/7.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEImagePickTableViewCellModel.h"
#import "NEImagePickTableViewCell.h"
@implementation NEImagePickTableViewCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.className = NSStringFromClass([NEImagePickTableViewCell class]);
        self.local_imagePaths = [NSArray array];
        self.isAlert = NO;
    }
    return self;
}



@end
