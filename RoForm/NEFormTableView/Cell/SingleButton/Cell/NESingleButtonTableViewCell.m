//
//  NESingleButtonTableViewCell.m
//  NETools
//
//  Created by roder on 2020/11/8.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NESingleButtonTableViewCell.h"
#import "NESingleButtonTableViewCellModel.h"
@interface NESingleButtonTableViewCell()
@end

@implementation NESingleButtonTableViewCell
@synthesize model = _model;
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)initViews{
    self.model.height = 84;
    NESingleButtonTableViewCellModel *model = (NESingleButtonTableViewCellModel *)self.model;
    model.button.layer.cornerRadius = 22;
    model.button.layer.masksToBounds = YES;
    [self.contentView addSubview:model.button];
    [model.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.height.equalTo(@44);
        make.leading.equalTo(self.contentView).offset(16);
        make.trailing.equalTo(self.contentView).offset(-16);
    }];
}

- (void)setModel:(NEFormTableViewCellModel *)model{
    _model = model;
    [self initViews];
}


@end
