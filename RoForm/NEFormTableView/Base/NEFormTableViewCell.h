//
//  NEFormTableViewCell.h
//  NETools
//
//  Created by roder on 2022/1/26.
//

#import <UIKit/UIKit.h>
#import "NEFormTableViewCellModel.h"
#import <Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <QMUIKit/QMUIKit.h>
#import "UIHelper.h"
#import "UIColor+NE.h"
#import "UIView+Custom.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NEFormTableViewCellDelegate <NSObject>
- (void)heightDidChange:(id)cell;
@end

@interface NEFormTableViewCell : UITableViewCell
@property (nonatomic,strong) NEFormTableViewCellModel *model;
@property (nonatomic,weak) id<NEFormTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
