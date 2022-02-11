//
//  NEFormTableView.h
//  NETools
//
//  Created by roder on 2022/1/26.
//

#import <UIKit/UIKit.h>
#import "NEFormTableViewCell.h"
#import "NEFormTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NEFormTableViewDelegate <NSObject>
- (void)heightDidChange;
@end


@interface NEFormTableView : UITableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style models:(NSArray<NSArray*>*)models;
- (void)updateWithModels:(NSArray<NSArray*>*)models;
@property (nonatomic,strong) NSArray<NSArray<NEFormTableViewCellModel*>*> *modelGroups;
@property(nonatomic, weak) id<NEFormTableViewDelegate> baseDelegate;

@end

NS_ASSUME_NONNULL_END
