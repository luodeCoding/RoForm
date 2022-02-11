//
//  NELabelCollectionView.m
//  NETools
//
//  Created by roder on 2020/12/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NELabelCollectionView.h"
#import "NELabelCollectionViewCell.h"
#import <Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIHelper.h"
#import "UIColor+NE.h"
#import "UIView+Custom.h"

@interface NELabelCollectionView() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,NELabelSelectCollectionViewCellDelegate>
@property (nonatomic,copy) NSArray<NSString*> *labels;
@property (nonatomic,strong) NSMutableArray<NSString*> *labels_selected;
@end

@implementation NELabelCollectionView
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 22;
    layout.minimumLineSpacing = 10;
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.labels_selected = [NSMutableArray array];
        [self registerClass:[NELabelCollectionViewCell class] forCellWithReuseIdentifier:@"NELabelCollectionViewCell"];
    }
    return self;
}

- (void)updateLabels:(NSArray<NSString*> *)labels{
    self.labels = [labels copy];
}

- (void)updatesSelectedLabels:(NSArray<NSString *> *)selectedLabels {
    if (selectedLabels) {
        self.labels_selected = [selectedLabels mutableCopy];
    }
}

#pragma mark collectionview delegate

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _labels.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NELabelCollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"NELabelCollectionViewCell" forIndexPath:indexPath];
    cell.labelName.text = [_labels objectAtIndex:indexPath.item];
    cell.delegate = self;
    cell.labelSelectModel = self.labelSelectModel;
    [cell refreshViews];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake((self.width - 22 * 3) / 3, 30);
    return size;
}

- (void)selectStateChange:(BOOL)isLabelSelected cell:(NELabelCollectionViewCell*)cell{
    NSIndexPath *indexpath = [self indexPathForCell:cell];
    NSString *label = self.labels[indexpath.item];
    
    if (!self.labelSelectModel.isMulti) {
        [self.labels_selected removeAllObjects];
        [self.labels_selected addObject:label];
        [self.labelsDelegate selectedLabelsChanged:[NSArray arrayWithArray:self.labels_selected]];
        return;
    }
    if (isLabelSelected) {
        BOOL isExist = NO;
        for (NSString *l in self.labels_selected) {
            if ([l isEqualToString:label]) {
                isExist = YES;
            }
        }
        if (!isExist) {
            [self.labels_selected addObject:label];
        }
    }
    else {
        NSString *label_toMove;
        for (NSString *l in self.labels_selected) {
            if ([l isEqualToString:label]) {
                label_toMove = l;
            }
        }
        if (label_toMove) {
            [self.labels_selected removeObject:label_toMove];
        }
    }
    [self.labelsDelegate selectedLabelsChanged:[NSArray arrayWithArray:self.labels_selected]];
}

@end
