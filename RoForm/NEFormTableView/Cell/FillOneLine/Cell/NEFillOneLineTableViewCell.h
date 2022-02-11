//
//  NEFillOneLineTableViewCell.h
//  NETools
//
//  Created by roder on 2020/11/5.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEFillOneLineTableViewCell : NEFormTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *necessaryImageView;
@property (weak, nonatomic) IBOutlet QMUITextField *contentTextField;
@property (strong, nonatomic) IBOutlet UILabel *unitLabel;

@end

NS_ASSUME_NONNULL_END
