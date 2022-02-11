//
//  NEImagePickTableViewCell.m
//  NETools
//
//  Created by roder on 2020/11/5.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEImagePickTableViewCell.h"
#import "NEImagePickCollectionView.h"
#import "NEImagePickTableViewCellModel.h"
@interface NEImagePickTableViewCell()<NEImagePickCollectionViewDelegate>
@property (strong, nonatomic) NEImagePickCollectionView *collectionView;
@end

@implementation NEImagePickTableViewCell
@synthesize model = _model;

- (void)awakeFromNib{
    [super awakeFromNib];
    _titleLabel.textColor = [UIHelper mainTextColor];
}

- (void)initViews{
    [_collectionView removeFromSuperview];
    NEImagePickTableViewCellModel *model = (NEImagePickTableViewCellModel *)self.model;
    _collectionView = [[NEImagePickCollectionView alloc] initWithImagePaths:model.local_imagePaths videoPath:model.local_videoPath maxPhotoNum:model.maxPhotoNum mode:model.mode isAlert:model.isAlert];
    _collectionView.model = model;
    _collectionView.videoMaximumSelectDuration = model.videoMaximumSelectDuration;
    _collectionView.videoMaximumShootDuration = model.videoMaximumShootDuration;
    _collectionView.ischangeVideoThumb = model.ischangeVideoThumb;
    _collectionView.imagePickDelegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(5);
        make.leading.equalTo(self).offset(SIDE_DISTANCE);
        make.trailing.equalTo(self).offset(-SIDE_DISTANCE);
        make.bottom.equalTo(self).offset(SIDE_DISTANCE);
    }];
    
    //发动态  二维码提示
    if(model.isQrcodeTip){
        UIImageView *tipImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"form_tagging"]];
        [self.contentView addSubview:tipImageView];
        [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16);
            make.bottom.offset(-25);
        }];
        
        
        UILabel *tipsLabel = [[UILabel alloc]init];
        tipsLabel.text = @"请勿上传带有二维码的敏感图片";
        tipsLabel.textColor = [UIColor grayColor];
        tipsLabel.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:tipsLabel];
        [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tipImageView.mas_right).offset(2);
            make.centerY.equalTo(tipImageView);
        }];
    }

}

- (void)setModel:(NEImagePickTableViewCellModel *)model{
    _model = model;
    [self.necessaryImageView setHidden:!model.isNecessary];
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    if (!model.subTitle) {
        self.icon.hidden = YES;
    }
    self.model.height = [self caculateheight];
    [self initViews];
}

- (CGFloat)caculateheight{
    CGFloat height = 60 + 5 + 16;
    
    NEImagePickTableViewCellModel *model = (NEImagePickTableViewCellModel *)self.model;
    if (model.local_videoPath) {
        //视频
        height = height + (MOMENTS_IMAGE_WIDTH * 1);
    }
    else if (model.local_imagePaths.count > 0){
        //照片
        NSInteger count = model.local_imagePaths.count;
        if (count == model.maxPhotoNum) {
            count = count - 1;
        }
        NSInteger remainder = (count + 1) % 3;
        NSInteger intger = (count + 1) / 3;
        height = height + intger * MOMENTS_IMAGES_SPACE + (intger * MOMENTS_IMAGE_WIDTH) + (remainder == 0 ? 0 : MOMENTS_IMAGE_WIDTH);
    }
    else {
        height = height + (MOMENTS_IMAGE_WIDTH * 1);
    }
    return height;
}

- (void)itemsDidChangeImagePaths:(nonnull NSArray<NSString *> *)imagePaths videoPath:(nonnull NSString *)videoPath videoThumbPath:(nonnull NSString *)videoThumbPath {
    NEImagePickTableViewCellModel *model = (NEImagePickTableViewCellModel *)self.model;
    model.local_videoPath = videoPath;
    model.local_videoThumbPath = videoThumbPath;
    model.local_imagePaths = [NSArray arrayWithArray:imagePaths];
    model.height = [self caculateheight];
    [self.delegate heightDidChange:self];
}
@end
