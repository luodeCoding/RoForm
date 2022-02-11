//
//  NEFillDetailTableViewCellModel.h
//  NETools
//
//  Created by roder on 2020/11/8.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEFillDetailTableViewCellModel : NEFormTableViewCellModel
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isNecessary;
@property (copy, nonatomic) NSString *contentText;
@property (copy, nonatomic) NSString *contentPlacehodlerText;

//限制字数
@property (nonatomic,assign) NSInteger limitNum;

@end

NS_ASSUME_NONNULL_END
