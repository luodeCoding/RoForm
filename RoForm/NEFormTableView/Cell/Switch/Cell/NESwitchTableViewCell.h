//
//  NESwitchTableViewCell.h
//  NETools
//
//  Created by roder on 2020/12/1.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NESwitchTableViewCell : NEFormTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *necessaryImageView;
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;

@end

NS_ASSUME_NONNULL_END
