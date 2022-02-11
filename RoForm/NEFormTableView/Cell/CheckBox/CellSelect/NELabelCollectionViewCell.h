//
//  NELabelCollectionViewCell.h
//  NETools
//
//  Created by roder on 2020/12/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NECheckBoxTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol NELabelSelectCollectionViewCellDelegate <NSObject>
- (void)selectStateChange:(BOOL)isLabelSelected cell:(id)cell;
@end
@interface NELabelCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, assign) BOOL isLabelSelected;
@property (nonatomic, weak) id<NELabelSelectCollectionViewCellDelegate> delegate;
@property (strong,nonatomic)NECheckBoxTableViewCellModel *labelSelectModel;

- (void)refreshViews;
@end

NS_ASSUME_NONNULL_END
