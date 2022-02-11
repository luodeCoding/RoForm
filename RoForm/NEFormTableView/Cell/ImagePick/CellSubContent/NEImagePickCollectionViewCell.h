//
//  NEImagePickCollectionViewCell.h
//  NETools
//
//  Created by roder on 2020/11/5.
//  Copyright © 2020 roder. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEImagePickCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *imageCloseButton;
@property (strong, nonatomic) IBOutlet UIImageView *playImageView;
@property (strong, nonatomic) IBOutlet UIButton *changeCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *lookoverBtn;
@end

NS_ASSUME_NONNULL_END
