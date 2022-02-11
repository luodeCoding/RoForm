//
//  NEFormTableViewCell.m
//  NETools
//
//  Created by roder on 2022/1/26.
//

#import "NEFormTableViewCell.h"

@implementation NEFormTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
