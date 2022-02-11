//
//  NEAddressPickTableViewCell.m
//  NETools
//
//  Created by roder on 2020/11/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEAddressPickTableViewCell.h"
#import "NEAddressPickTableViewCellModel.h"
#import <BRPickerView.h>

@interface NEAddressPickTableViewCell()

@end

@implementation NEAddressPickTableViewCell
@synthesize model = _model;

- (void)awakeFromNib {
    [super awakeFromNib];
    _titleLabel.textColor = [UIHelper mainTextColor];
}

- (void)setModel:(NEAddressPickTableViewCellModel *)model{
    if (_model != model) {
        _model = model;
        self.titleLabel.text = model.title;
        [self.necessaryImageView setHidden:!model.isNecessary];
        if (model.address == nil || model.address.length == 0) {
            self.addressLabel.text = model.addressNamePlaceHolderText;
            self.addressLabel.textColor = [UIColor grayColor];
        }
        else {
            self.addressLabel.text = model.address;
            self.addressLabel.textColor = [UIHelper mainTextColor];
        }
        [self.addressLabel setUserInteractionEnabled:YES];
        [self.addressLabel.superview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAddressPicker)]];
        self.model.height = 48;
    }
}

- (void)showAddressPicker {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    BRAddressPickerView *addressPickerView = [[BRAddressPickerView alloc]init];
    addressPickerView.pickerMode = BRAddressPickerModeArea;
    addressPickerView.title = @"城市选择";
    addressPickerView.isAutoSelect = YES;
    @weakify(self);
    addressPickerView.resultBlock = ^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        @strongify(self);
        NEAddressPickTableViewCellModel *model = (NEAddressPickTableViewCellModel *)self.model;
        self.addressLabel.textColor = [UIHelper mainTextColor];
        if ([area.name isEqualToString:@""]) {
            self.addressLabel.text = [NSString stringWithFormat:@"%@-%@", province.name, city.name];
            model.address = [NSString stringWithFormat:@"%@-%@", province.name, city.name];
        }else{
            self.addressLabel.text = [NSString stringWithFormat:@"%@-%@-%@", province.name, city.name, area.name];
            model.address = [NSString stringWithFormat:@"%@-%@-%@", province.name, city.name, area.name];
        }
    
        model.provinceLabel = province.name;
        model.cityLabel = city.name;
        model.areaLabel = area.name;
        
        model.provinceCode = province.code;
        model.cityCode = city.code;
        model.areaCode = area.code;
    };

    [addressPickerView show];
}
@end
