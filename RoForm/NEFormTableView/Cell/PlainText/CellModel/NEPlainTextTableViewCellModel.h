//
//  NEPlainTextTableViewCellModel.h
//  NETools
//
//  Created by roder on 2020/12/21.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEPlainTextTableViewCellModel : NEFormTableViewCellModel
@property (nonatomic,strong)NSString *title;
@property (assign, nonatomic) BOOL isNecessary;
@end

NS_ASSUME_NONNULL_END
