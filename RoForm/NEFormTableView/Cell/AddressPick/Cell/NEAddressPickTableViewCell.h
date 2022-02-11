//
//  NEAddressPickTableViewCell.h
//  NETools
//
//  Created by roder on 2020/11/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEAddressPickTableViewCell : NEFormTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *necessaryImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

NS_ASSUME_NONNULL_END
