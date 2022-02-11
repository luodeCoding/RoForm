//
//  NEDatePickTableViewCellModel.m
//  NETools
//
//  Created by roder on 2020/11/8.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEDatePickTableViewCellModel.h"
#import "NEDatePickTableViewCell.h"

@implementation NEDatePickTableViewCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.className = NSStringFromClass([NEDatePickTableViewCell class]);
        _formatter1 = [[NSDateFormatter alloc] init];
        _formatter2 = [[NSDateFormatter alloc] init];
    }
    return self;
}

- (void)setDate1_type:(NEDatePickType)date1_type{
    _date1_type = date1_type;
    switch (_date1_type) {
        case NEDatePickType_ymd:
            [_formatter1 setDateFormat:@"yyyy-MM-dd"];
            break;
        case NEDatePickType_ymd_hm:
            [_formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
    }
}

- (void)setDate2_type:(NEDatePickType)date2_type{
    _date2_type = date2_type;
    switch (_date2_type) {
        case NEDatePickType_ymd:
            [_formatter2 setDateFormat:@"yyyy-MM-dd"];
            break;
        case NEDatePickType_ymd_hm:
            [_formatter2 setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
    }
}


@end
