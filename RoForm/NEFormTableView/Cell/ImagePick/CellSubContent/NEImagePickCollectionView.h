//
//  NEImagePickCollectionView.h
//  NETools
//
//  Created by roder on 2020/11/5.
//  Copyright © 2020 roder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NEImagePickTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol NEImagePickCollectionViewDelegate <NSObject>
- (void)itemsDidChangeImagePaths:(NSArray<NSString*>*)imagePaths videoPath:(NSString*)videoPath videoThumbPath:(NSString*)videoThumbPath;

@end

@interface NEImagePickCollectionView : UICollectionView
@property (weak, nonatomic) id<NEImagePickCollectionViewDelegate> imagePickDelegate;
@property (nonatomic,assign) NSInteger videoMaximumSelectDuration;
@property (nonatomic,assign) NSInteger videoMaximumShootDuration;
//是否支持修改视频封面
@property (nonatomic,assign) BOOL ischangeVideoThumb;

- (instancetype)initWithImagePaths:(NSArray<NSString*> *)imagePath videoPath:(NSString*)videoPath maxPhotoNum:(NSInteger)maxPhotoNum mode:(NSInteger)mode isAlert:(BOOL)isAlert;

@property (nonatomic, strong) NEImagePickTableViewCellModel *model;
@end

NS_ASSUME_NONNULL_END
