//
//  NELabelCollectionView.h
//  NETools
//
//  Created by roder on 2020/12/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NECheckBoxTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol NELableSelectCollectionViewDelegate <NSObject>
- (void)selectedLabelsChanged:(NSArray<NSString*> *)labels_selected;
@end

@interface NELabelCollectionView : UICollectionView
- (void)updateLabels:(NSArray<NSString*> *)labels;
- (void)updatesSelectedLabels:(NSArray<NSString*> *)selectedLabels;
@property (weak,nonatomic) id<NELableSelectCollectionViewDelegate> labelsDelegate;
@property (strong,nonatomic)NECheckBoxTableViewCellModel *labelSelectModel;

@end
NS_ASSUME_NONNULL_END
