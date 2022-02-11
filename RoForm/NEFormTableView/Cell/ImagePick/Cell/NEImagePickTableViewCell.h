//
//  NEImagePickTableViewCell.h
//  NETools
//
//  Created by roder on 2020/11/5.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEImagePickTableViewCell : NEFormTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UIImageView *necessaryImageView;
@end

NS_ASSUME_NONNULL_END
