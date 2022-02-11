//
//  NEDatePickTableViewCellModel.h
//  NETools
//
//  Created by roder on 2020/11/8.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NEDatePickType) {
    //年月日时分
    NEDatePickType_ymd_hm = 0,
    //年月日
    NEDatePickType_ymd,
};

typedef NS_ENUM(NSUInteger, NEDatePickTableViewCellModelType) {
    //一个时间
    NEDatePickTableViewCellModelType_one = 0,
    //两个时间
    NEDatePickTableViewCellModelType_two,
};

@interface NEDatePickTableViewCellModel : NEFormTableViewCellModel
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isNecessary;
//时间1
@property (nonatomic,copy) NSString *date1;
//时间2
@property (nonatomic,copy) NSString *date2;
@property (nonatomic,assign) NEDatePickType date1_type;
@property (nonatomic,assign) NEDatePickType date2_type;
@property (nonatomic,strong) NSDateFormatter *formatter1;
@property (nonatomic,strong) NSDateFormatter *formatter2;
@property (nonatomic,assign) NEDatePickTableViewCellModelType type;
@property (nonatomic,strong) NSString *placeholderText1;
@property (nonatomic,strong) NSString *placeholderText2;
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,assign) BOOL isMin;// 能否到最小时间
@end

NS_ASSUME_NONNULL_END
