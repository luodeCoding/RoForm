//
//  NEPlainTextTableViewCell.h
//  NETools
//
//  Created by roder on 2020/12/21.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEPlainTextTableViewCell : NEFormTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *necessaryImageView;
@property (weak, nonatomic) IBOutlet UILabel *plaintext;

@end

NS_ASSUME_NONNULL_END
