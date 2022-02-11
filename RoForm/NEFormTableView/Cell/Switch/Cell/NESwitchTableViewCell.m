//
//  NESwitchTableViewCell.m
//  NETools
//
//  Created by roder on 2020/12/1.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NESwitchTableViewCell.h"
#import "NESwitchTableViewCellModel.h"

@implementation NESwitchTableViewCell
@synthesize model = _model;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [UIHelper mainTextColor];
    @weakify(self);
    [[self.switchControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NESwitchTableViewCellModel *model = (NESwitchTableViewCellModel *)self.model;
        model.switchOn = self.switchControl.on;
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(NESwitchTableViewCellModel *)model{
    if (_model != model) {
        _model = model;
        self.model.height = 48;
        self.titleLabel.text = model.title;
        [self.necessaryImageView setHidden:!model.isNecessary];
        [self.switchControl setOn:model.switchOn];
    }
}

@end
