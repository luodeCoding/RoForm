//
//  NEFillOneLineTableViewCellModel.h
//  NETools
//
//  Created by roder on 2020/11/6.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEFillOneLineTableViewCellModel : NEFormTableViewCellModel
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isNecessary;
@property (assign, nonatomic) BOOL isNotInputed;
@property (assign, nonatomic) UIKeyboardType inputKeyBoardType;
@property (assign, nonatomic) NSInteger inputLimitNum;// 限制位数
@property (assign, nonatomic) NSInteger inputPointNum;// 显示小数点后位数
@property (copy, nonatomic) NSString *contentText;
@property (copy, nonatomic) NSString *contentPlaceHolderText;
@property (copy, nonatomic) NSString *inputUnit;// 单位
@end

NS_ASSUME_NONNULL_END
