//
//  NELabelCollectionViewCell.m
//  NETools
//
//  Created by roder on 2020/12/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NELabelCollectionViewCell.h"
#import <Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIHelper.h"
#import "UIColor+NE.h"
#import "UIView+Custom.h"

@interface NELabelCollectionViewCell()
@property (nonatomic, strong) UIView *labelBackview;
@property (nonatomic, strong) UIImageView *roundview;

@end

@implementation NELabelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        self.isLabelSelected = NO;
    }
    return self;
}

- (void)initViews{
    _labelBackview = [[UIView alloc] init];
    [_labelBackview setCornerRadius:16];
    [self.contentView addSubview:_labelBackview];
    [_labelBackview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
    }];
    
    _roundview = [[UIImageView alloc]init];
    _roundview.image = [UIImage imageNamed:@"form_checkBox_nor"];
    [_labelBackview addSubview:_roundview];
    [_roundview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.left.mas_equalTo(5);
        make.size.mas_offset(CGSizeMake(16, 16));

    }];
    
    _labelName = [[UILabel alloc] init];
    _labelName.textAlignment = NSTextAlignmentCenter;
    _labelName.font = [UIFont systemFontOfSize:13];
    _labelName.textColor = [UIHelper mainTextColor];
    [_labelBackview addSubview:_labelName];
    [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.labelBackview).insets(UIEdgeInsetsZero);
    }];
    [_labelBackview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf)]];
}

- (void)refreshViews {
    
    BOOL isExist = NO;
    for (NSString *l in self.labelSelectModel.labels_selected) {
        if ([l isEqualToString:self.labelName.text]) {
            isExist = YES;
        }
    }
    if (!isExist) {
        _roundview.image = [UIImage imageNamed:@"form_checkBox_nor"];
        self.isLabelSelected = NO;
    } else {
        _roundview.image = [UIImage imageNamed:@"form_checkBox_sel"];
        self.isLabelSelected = YES;
    }
}

- (void)tapSelf{
    if (self.labelSelectModel.maxNum && self.labelSelectModel.labels_selected.count >= self.labelSelectModel.maxNum) {
        BOOL isExist = NO;
        for (NSString *l in self.labelSelectModel.labels_selected) {
            if ([l isEqualToString:self.labelName.text]) {
                isExist = YES;
            }
        }
        if (isExist) {
            self.isLabelSelected = NO;
            [self.delegate selectStateChange:self.isLabelSelected cell:self];
        }
        return;
    }
    if (self.labelSelectModel.isMulti) {
        self.isLabelSelected = !self.isLabelSelected;
    } else {
        self.isLabelSelected = YES;
    }
    [self.delegate selectStateChange:self.isLabelSelected cell:self];
}

@end
