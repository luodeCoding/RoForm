//
//  NEImagePickTableViewCellModel.h
//  NETools
//
//  Created by roder on 2020/11/7.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCellModel.h"
#import "HXPhotoPicker.h"

NS_ASSUME_NONNULL_BEGIN
@interface NEImagePickTableViewCellModel : NEFormTableViewCellModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (assign, nonatomic) BOOL isNecessary;
@property (nonatomic, strong) NSAttributedString *titleAttri;
//本地资源路径
@property (nonatomic, strong) NSArray<NSString*> *local_imagePaths;
@property (nonatomic, copy, nullable) NSString *local_videoPath;
@property (nonatomic, copy) NSString *local_videoThumbPath;
//最大图片数量
@property (nonatomic, assign) NSInteger maxPhotoNum;
//模式    0: 视频、图片模式 1：图片 2：视频
@property (nonatomic, assign) NSInteger mode;
//标签类型 是否为弹窗类型
@property (nonatomic,assign) BOOL isAlert;
//是否支持修改视频封面
@property (nonatomic,assign) BOOL ischangeVideoThumb;

@property (nonatomic,assign) NSArray <HXPhotoModel *>* imgs;
//视频最大选择时间
@property (nonatomic,assign) NSInteger videoMaximumSelectDuration;
//视频最大拍摄时间
@property (nonatomic,assign) NSInteger videoMaximumShootDuration;
//发动态 是否包含敏感二维码提示  
@property (nonatomic, assign) BOOL isQrcodeTip;

//当前选中视频时间
@property (nonatomic,assign) NSInteger currentVideoDuration;
@end

NS_ASSUME_NONNULL_END
