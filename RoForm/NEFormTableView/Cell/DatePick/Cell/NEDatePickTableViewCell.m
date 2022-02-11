//
//  NEDatePickTableViewCell.m
//  NETools
//
//  Created by roder on 2020/11/8.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEDatePickTableViewCell.h"
#import "NEDatePickTableViewCellModel.h"
#import "BRDatePickerView.h"

@interface NEDatePickTableViewCell()
@property (strong, nonatomic) UILabel *date1Label;
@property (strong, nonatomic) UILabel *date2Label;
@property (strong, nonatomic) UILabel *splitLabel;
@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UITapGestureRecognizer *tapGesture1;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture2;

@property (assign, nonatomic) BOOL changeDate;
@end

@implementation NEDatePickTableViewCell
@synthesize model = _model;
- (void)awakeFromNib {
    [super awakeFromNib];
    _titleLabel.textColor = [UIHelper mainTextColor];
    _date1Label.textColor = [UIHelper mainTextColor];
    _date2Label.textColor = [UIHelper mainTextColor];
    _splitLabel.textColor = [UIHelper mainTextColor];
}

- (void)initViews{
    NEDatePickTableViewCellModel *model = (NEDatePickTableViewCellModel *)self.model;
    [_date1Label removeFromSuperview];
    [_date2Label removeFromSuperview];
    [_splitLabel removeFromSuperview];
    [_backView removeFromSuperview];
    
    _date1Label = [[UILabel alloc] init];
    _date2Label = [[UILabel alloc] init];
    _splitLabel = [[UILabel alloc] init];
    _date1Label.font = [UIFont systemFontOfSize:15];
    _date2Label.font = [UIFont systemFontOfSize:15];
    _splitLabel.font = [UIFont systemFontOfSize:15];
    _splitLabel.text = @"至";
    _date2Label.textAlignment = NSTextAlignmentRight;
    
    [_date1Label setUserInteractionEnabled:YES];
    [_date2Label setUserInteractionEnabled:YES];
    
    _tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDatePicker:)];
    [_date1Label addGestureRecognizer:_tapGesture1];
    
    _tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDatePicker:)];
    [_date2Label addGestureRecognizer:_tapGesture2];

    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"form_arrow_right"];
    [self.contentView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@16);
        make.centerY.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView).offset(-16);
    }];
    if (model.type == NEDatePickTableViewCellModelType_one) {
        if (_changeDate) {
            _date1Label.text = [self dateStringWithNEDatePickerType:model.date1_type dateIndex:1];
            _date1Label.textColor = [UIHelper mainTextColor];
        } else {
            if (model.isEdit == YES) {
                _date1Label.text = [self dateStringWithNEDatePickerType:model.date1_type dateIndex:1];
                _date1Label.textColor = [UIHelper mainTextColor];
            }else{
                if (model.date1) {
                    _date1Label.text = [self dateStringWithNEDatePickerType:model.date1_type dateIndex:1];
                    _date1Label.textColor = [UIHelper mainTextColor];
                } else {
                    _date1Label.text = model.placeholderText1;
                    _date1Label.textColor = [UIColor grayColor];
                }
            }
        }
        [self.contentView addSubview:_date1Label];
        [_date1Label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView.mas_leading).offset(118);
            make.centerY.equalTo(self.contentView);
            make.trailing.equalTo(arrowImageView).offset(-10);
        }];
    }
    else {
        if (_changeDate) {
            _date1Label.text = [self dateStringWithNEDatePickerType:model.date1_type dateIndex:1];
            _date2Label.text = [self dateStringWithNEDatePickerType:model.date2_type dateIndex:2];
            _date1Label.textColor = [UIHelper mainTextColor];
            _date2Label.textColor = [UIHelper mainTextColor];
        } else {
            _date1Label.text = model.placeholderText1;
            _date2Label.text = model.placeholderText2;
            _date1Label.textColor = [UIColor grayColor];
            _date2Label.textColor = [UIColor grayColor];
        }
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self.contentView addSubview:_backView];
        [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView.mas_leading).offset(118);
            make.trailing.equalTo(arrowImageView).offset(-10);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
        }];
        
        [_backView addSubview:_splitLabel];
        [_splitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_backView);
        }];

        [_backView addSubview:_date1Label];
        [_date1Label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_backView).offset(0);
            make.trailing.equalTo(_splitLabel.mas_leading).offset(5);
            make.centerY.equalTo(_backView);
        }];

        [_backView addSubview:_date2Label];
        [_date2Label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_splitLabel.mas_trailing).offset(0);
            make.trailing.equalTo(_backView).offset(5);
            make.centerY.equalTo(_backView);
        }];
    }
}

- (void)setModel:(NEDatePickTableViewCellModel *)model{
    if (_model != model) {
        _model = model;
        self.model.height = 48;
        self.titleLabel.text = model.title;
        [self.necessaryImageView setHidden:!model.isNecessary];
        [self initViews];
    }
}

- (NSString *)dateStringWithNEDatePickerType:(NEDatePickType)type dateIndex:(NSInteger)index{
    NEDatePickTableViewCellModel *model = (NEDatePickTableViewCellModel *)self.model;
    if (index == 1) {
        return model.date1 == nil ? [model.formatter1 stringFromDate:[NSDate date]] : model.date1;
    }
    else {
        return model.date2 == nil ? [model.formatter2 stringFromDate:[NSDate date]] : model.date2;
    }
}

- (void)tapDatePicker:(UITapGestureRecognizer*)gesture{
    NEDatePickTableViewCellModel *model = (NEDatePickTableViewCellModel *)self.model;
    if (gesture == _tapGesture1) {
        [self showDatePicker:model.date1_type datePickIndex:1];
    }
    else {
        [self showDatePicker:model.date2_type datePickIndex:2];
    }
}

- (void)showDatePicker:(NEDatePickType)type datePickIndex:(NSInteger)index{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NEDatePickTableViewCellModel *model = (NEDatePickTableViewCellModel *)self.model;
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    datePickerView.numberFullName = YES;
    // 2.设置属性
    if (type == NEDatePickType_ymd) {
        datePickerView.pickerMode = BRDatePickerModeYMD;
    }
    if (type == NEDatePickType_ymd_hm) {
        datePickerView.pickerMode = BRDatePickerModeYMDHM;
    }
    datePickerView.title = @"选择时间";
    if (!model.isMin) {
        datePickerView.minDate = [NSDate date];
    }else{
        datePickerView.minDate = [NSDate br_setYear:1900 month:01 day:01];

    }
    datePickerView.maxDate = [NSDate br_setYear:2030 month:12 day:30];
    datePickerView.isAutoSelect = YES;
    @weakify(self);
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        @strongify(self);
        self.changeDate = YES;
        if (index == 1) {
            self.date1Label.text = selectValue;
            model.date1 = [model.formatter1 stringFromDate:selectDate];
        }
        else {
            self.date2Label.text = selectValue;
            model.date2 = [model.formatter2 stringFromDate:selectDate];
        }
        self.date1Label.textColor = [UIHelper mainTextColor];
        self.date2Label.textColor = [UIHelper mainTextColor];
    };
    NSString *dateStr;
    NEDatePickType date_type;
    NSDateFormatter *formatter;
    //初始化时间
    if (index == 1) {
        dateStr = model.date1;
        date_type = model.date1_type;
        formatter = model.formatter1;
    }
    else {
        dateStr = model.date2;
        date_type = model.date2_type;
        formatter = model.formatter2;
    }
    if (dateStr != nil) {
        NSDate *date = [formatter dateFromString:dateStr];
        datePickerView.selectDate = date;
    }
    else {
        datePickerView.selectDate = [NSDate date];
    }
    // 3.显示
    [datePickerView show];
}

@end
