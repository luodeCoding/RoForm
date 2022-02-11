//
//  NECheckBoxTableViewCell.m
//  NETools
//
//  Created by roder on 2020/12/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NECheckBoxTableViewCell.h"
#import "NECheckBoxTableViewCellModel.h"
#import "NELabelCollectionView.h"
@interface NECheckBoxTableViewCell()<NELableSelectCollectionViewDelegate>
@property (nonatomic,copy) NELabelCollectionView *collectionView;
@end

@implementation NECheckBoxTableViewCell
@synthesize model = _model;
- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [UIHelper mainTextColor];
}

- (void)setModel:(NECheckBoxTableViewCellModel *)model{
    if (_model != model) {
        _model = model;
        [self initViews];
        self.titleLabel.text = model.title;
        self.model.height = [self caculateheight];
        self.collectionView.labelSelectModel = model;
        [self.collectionView updateLabels:model.labels];
        [self.collectionView updatesSelectedLabels:model.labels_selected];
        [self.collectionView reloadData];
    }
}

- (void)initViews{
    NECheckBoxTableViewCellModel *model = (NECheckBoxTableViewCellModel *)self.model;
    [self.necessaryImageView setHidden:!model.isNecessary];
}

- (CGFloat)caculateheight{
    CGFloat height = 12 + 26;
    NECheckBoxTableViewCellModel *model = (NECheckBoxTableViewCellModel *)self.model;
    NSInteger remainder = model.labels.count % 3;
    NSInteger intger = model.labels.count / 3;

    if (model.labels.count <= 3) {
        height = (height + LABELSVIEW_CELL_HEIGHT);
    }
    else {
        height = height + (intger * LABELSVIEW_CELL_LINESPACE) + (intger * LABELSVIEW_CELL_HEIGHT) + (remainder == 0 ? 0 : LABELSVIEW_CELL_HEIGHT);
    }
    return height + 26;
}

- (void)selectedLabelsChanged:(NSArray<NSString*> *)labels_selected{
    NECheckBoxTableViewCellModel *model = (NECheckBoxTableViewCellModel *)self.model;
    model.labels_selected = [labels_selected copy];
    _collectionView.labelSelectModel = model;
    [self.collectionView reloadData];
    [model.seletSub sendNext:labels_selected];
}

- (NELabelCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[NELabelCollectionView alloc] init];
        _collectionView.labelsDelegate = self;
        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
            make.leading.equalTo(self).offset(SIDE_DISTANCE);
            make.trailing.equalTo(self).offset(-SIDE_DISTANCE);
            make.bottom.equalTo(self).offset(SIDE_DISTANCE);
        }];
    }
    return _collectionView;
}

@end

