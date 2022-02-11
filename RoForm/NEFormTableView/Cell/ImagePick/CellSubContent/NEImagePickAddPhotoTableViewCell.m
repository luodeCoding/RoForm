//
//  NEImagePickAddPhotoTableViewCell.m
//  NETools
//
//  Created by roder on 2020/11/7.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEImagePickAddPhotoTableViewCell.h"

@implementation NEImagePickAddPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.addPhotoBtn.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.addPhotoBtn setImage:[UIImage imageNamed:@"form_addPhoto"] forState:UIControlStateNormal];
}

@end
