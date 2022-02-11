//
//  NESwitchTableViewCell.h
//  NETools
//
//  Created by roder on 2020/12/1.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NESwitchTableViewCellModel : NEFormTableViewCellModel
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isNecessary;
@property (assign, nonatomic) BOOL switchOn;
@end

NS_ASSUME_NONNULL_END
