//
//  NEImagePickCollectionView.m
//  NETools
//
//  Created by roder on 2020/11/5.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEImagePickCollectionView.h"
#import <QMUIKit/QMUIKit.h>
#import "UIHelper.h"
#import "UIColor+NE.h"
#import "UIView+Custom.h"
#import "KSPhotoBrowser.h"

#import "NEImagePickCollectionViewCell.h"
#import "NEImagePickAddPhotoTableViewCell.h"
#import "NEImagePickTableViewCellModel.h"
#import "AppDelegate.h"
#import "NEVideoCoverVC.h"

typedef NS_ENUM(NSUInteger, NEImagePickerAssetState) {
    NEImagePickerAssetState_None,
    NEImagePickerAssetState_photoNotFull,
    NEImagePickerAssetState_photoFull,
    NEImagePickerAssetState_video
};

@interface NEImagePickCollectionView() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,HXCustomNavigationControllerDelegate>
@property (nonatomic,strong) HXPhotoManager *manager;
@property (nonatomic, strong) NSMutableArray<NSString*> *local_imagePaths;
@property (nonatomic, copy) NSString *local_videoPath;
@property (nonatomic, copy) NSString *local_videoThumbPath;
@property (nonatomic, assign) NSInteger maxPhotoNum;
//模式    0: 视频、图片模式 1：图片 2：视频
@property (nonatomic, assign) NSInteger mode;
//标签类型 是否为弹窗类型
@property (nonatomic,assign) BOOL isAlert;
//@property (weak, nonatomic) id<NEImagePickCollectionViewDelegate> imagePickDelegate;
@end

@implementation NEImagePickCollectionView

- (instancetype)initWithImagePaths:(NSArray<NSString*> *)imagePath videoPath:(NSString*)videoPath maxPhotoNum:(NSInteger)maxPhotoNum mode:(NSInteger)mode isAlert:(BOOL)isAlert;
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = MOMENTS_IMAGES_SPACE;
    layout.minimumLineSpacing = MOMENTS_IMAGES_SPACE;
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.mode = mode;
        self.isAlert = isAlert;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.maxPhotoNum = maxPhotoNum;
        self.local_imagePaths = [[NSMutableArray alloc] init];
        [self.local_imagePaths addObjectsFromArray:imagePath];
        self.local_videoPath = videoPath;
        [self registerNib:[UINib nibWithNibName:@"NEImagePickCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NEImagePickCollectionViewCell"];
        [self registerNib:[UINib nibWithNibName:@"NEImagePickAddPhotoTableViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NEImagePickAddPhotoTableViewCell"];
        self.local_videoThumbPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"videoThumb.png"];
    }
    return self;
}

- (void)addPhoto{
    self.manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
    self.manager.configuration.photoMaxNum = self.maxPhotoNum - self.local_imagePaths.count;
    self.manager.configuration.openCamera = YES;
    HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithManager:self.manager delegate:self];
    nav.isCamera = YES;
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}




- (void)addVideo{
    self.manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypeVideo];
    self.manager.configuration.videoMaxNum = 1;
    self.manager.configuration.openCamera = YES;
    self.manager.configuration.videoMinimumDuration = 3;
    self.manager.configuration.videoMinimumSelectDuration = 3;
    self.manager.configuration.videoMaximumDuration = self.videoMaximumShootDuration ? self.videoMaximumShootDuration : 60;
    self.manager.configuration.videoMaximumSelectDuration = self.videoMaximumSelectDuration ? self.videoMaximumSelectDuration : 60;
    
    HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithManager:self.manager delegate:self];
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)tapAddBtn:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    switch ([self currentState]) {
        case NEImagePickerAssetState_None:
        {
            if (_mode == 0) {
                [alert addAction:[UIAlertAction actionWithTitle:@"添加照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self addPhoto];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"添加视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self addVideo];
                }]];
            }
            else if (_mode == 1) {
                [alert addAction:[UIAlertAction actionWithTitle:@"添加照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self addPhoto];
                }]];
            }
            else if (_mode == 2) {
                [alert addAction:[UIAlertAction actionWithTitle:@"添加视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self addVideo];
                }]];
            }
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        }
            break;
        case NEImagePickerAssetState_photoNotFull:
        {
            [alert addAction:[UIAlertAction actionWithTitle:@"添加照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self addPhoto];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        }
            break;
        default:
            return;
            break;
    }
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)removeItemWithCell:(UICollectionViewCell*)cell{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    switch ([self currentState]) {
        case NEImagePickerAssetState_photoNotFull:
        case NEImagePickerAssetState_photoFull:
            [self.local_imagePaths removeObjectAtIndex:indexPath.item];
            break;
        case NEImagePickerAssetState_video:
            self.local_videoPath = nil;
            break;
        default:
            return;
            break;
    }
    [self.imagePickDelegate itemsDidChangeImagePaths:self.local_imagePaths videoPath:self.local_videoPath videoThumbPath:self.local_videoThumbPath];
}

- (NEImagePickerAssetState)currentState{
    if (self.local_imagePaths.count == 0) {
        //照片为0
        if (self.local_videoPath == nil){
            //没任何照片视频，唯一添加按钮
            return NEImagePickerAssetState_None;
        }
        else {
            //唯一视频
            return NEImagePickerAssetState_video;
        }
    }
    else{
        //照片存在
        if (self.local_imagePaths.count < self.maxPhotoNum) {
            return NEImagePickerAssetState_photoNotFull;
        }
        else {
            return NEImagePickerAssetState_photoFull;
        }
    }
}

#pragma mark HXPhoto delegate
- (void)photoNavigationViewController:(HXCustomNavigationController *)photoNavigationViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original{
    [QMUITips showLoadingInView:[UIApplication sharedApplication].keyWindow];
    dispatch_group_t group = dispatch_group_create();
    for (HXPhotoModel *model in photoList) {
        if (model.subType == HXPhotoModelMediaSubTypePhoto && (model.type == HXPhotoModelMediaTypeCameraPhoto || model.type == HXPhotoModelMediaTypePhoto)) {
            CGSize size;
            if (original) {
                size = PHImageManagerMaximumSize;
            }else {
                size = CGSizeMake(model.imageSize.width * 0.5, model.imageSize.height * 0.5);
            }
            dispatch_group_enter(group);
            @weakify(self);
            [model getAssetURLWithSuccess:^(NSURL * _Nullable URL, HXPhotoModelMediaSubType mediaType, BOOL isNetwork, HXPhotoModel * _Nullable model) {
                @strongify(self);
                if (self.local_imagePaths.count < self.maxPhotoNum) {
                    [self.local_imagePaths addObject:model.imageURL.absoluteString];
                    dispatch_group_leave(group);
                }
            } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
                
            }];
        }
    }
    for (HXPhotoModel *model in videoList) {
        if (model.subType == HXPhotoModelMediaSubTypeVideo && (model.type == HXPhotoModelMediaTypeVideo || model.type == HXPhotoModelMediaTypeCameraVideo)) {
            dispatch_group_enter(group);
            @weakify(self);
            [model getAssetURLWithSuccess:^(NSURL * _Nullable URL, HXPhotoModelMediaSubType mediaType, BOOL isNetwork, HXPhotoModel * _Nullable model) {
                @strongify(self);
                self.local_videoPath = URL.absoluteString;
                self.model.currentVideoDuration = model.videoDuration;
                dispatch_group_leave(group);
            } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
                
            }];
            
            dispatch_group_enter(group);
            [model requestPreviewImageWithSize:CGSizeMake(343, 223) startRequestICloud:^(PHImageRequestID iCloudRequestId, HXPhotoModel * _Nullable model) {
                
            } progressHandler:^(double progress, HXPhotoModel * _Nullable model) {

            } success:^(UIImage * _Nullable image, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
                @strongify(self);
                BOOL result = [UIImagePNGRepresentation(image) writeToFile:self.local_videoThumbPath atomically:YES];
                if (result == YES) {
                    NSLog(@"保存成功");
                }
                dispatch_group_leave(group);
            } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {

            }];
        }
    }
    @weakify(self);
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        @strongify(self);
        [QMUITips hideAllTips];
        [self.imagePickDelegate itemsDidChangeImagePaths:self.local_imagePaths videoPath:self.local_videoPath videoThumbPath:self.local_videoThumbPath];
    });
}

#pragma mark collectionview delegate

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch ([self currentState]) {
        case NEImagePickerAssetState_None:
            return 1;
            break;
        case NEImagePickerAssetState_photoNotFull:
            return self.local_imagePaths.count + 1;
            break;
        case NEImagePickerAssetState_photoFull:
            return self.maxPhotoNum;
            break;
        case NEImagePickerAssetState_video:
            return 1;
            break;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch ([self currentState]) {
        case NEImagePickerAssetState_None:
            return [self addAssetCellWithIndexPath:indexPath];
            break;
        case NEImagePickerAssetState_photoNotFull:
            if (indexPath.item == self.local_imagePaths.count) {
                return [self addAssetCellWithIndexPath:indexPath];
            }
            else{
                return [self assetCellWithImageURL:[NSURL URLWithString:self.local_imagePaths[indexPath.item]] orImagePath:nil indexPath:indexPath];
            }
            break;
        case NEImagePickerAssetState_photoFull:
        {
            return [self assetCellWithImageURL:[NSURL URLWithString:self.local_imagePaths[indexPath.item]] orImagePath:nil indexPath:indexPath];
        }
            break;
        case NEImagePickerAssetState_video:
        {
            return [self assetCellWithImageURL:nil orImagePath:self.local_videoThumbPath indexPath:indexPath];
        }
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isAlert) {
        return CGSizeMake(MOMENTS_POP_IMAGE_WIDTH, MOMENTS_POP_IMAGE_WIDTH);
    }
    return CGSizeMake(MOMENTS_IMAGE_WIDTH, MOMENTS_IMAGE_WIDTH);
}

- (NEImagePickAddPhotoTableViewCell *)addAssetCellWithIndexPath:(NSIndexPath *)indexPath{
    NEImagePickAddPhotoTableViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"NEImagePickAddPhotoTableViewCell" forIndexPath:indexPath];
    [cell.addPhotoBtn addTarget:self action:@selector(tapAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (NEImagePickCollectionViewCell *)assetCellWithImageURL:(NSURL *)imageUrl orImagePath:(NSString*)imagePath indexPath:(NSIndexPath *)indexPath{
    NEImagePickCollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"NEImagePickCollectionViewCell" forIndexPath:indexPath];
    cell.lookoverBtn.hidden = YES;
    if (imageUrl) {
        [cell.imageView sd_setImageWithURL:imageUrl];
        cell.playImageView.hidden = YES;
        cell.changeCoverButton.hidden = YES;
        cell.lookoverBtn.hidden = NO;
    }
    if (imagePath) {
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:self.local_videoThumbPath]];
        cell.playImageView.hidden = !self.ischangeVideoThumb;            
        cell.changeCoverButton.hidden = !self.ischangeVideoThumb;
        cell.lookoverBtn.hidden = self.ischangeVideoThumb;
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    [cell addGestureRecognizer:longPress];
    
    @weakify(self);
    // 删除图片
    [[[cell.imageCloseButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [cell.imageCloseButton setUserInteractionEnabled:NO];
        [self removeItemWithCell:cell];
    }];
    
    // 视频封面剪辑
    [[[cell.changeCoverButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NEVideoCoverVC *videoCoverVC = [[NEVideoCoverVC alloc]init];
        videoCoverVC.modalPresentationStyle = UIModalPresentationFullScreen;
        videoCoverVC.videoUrl = [NSURL URLWithString:self.local_videoPath];
        videoCoverVC.local_videoThumbPath = self.local_videoThumbPath;
        videoCoverVC.videoCoverBlock = ^{
            [self reloadData];
        };
//        [[TXBaseViewController recursiveFindCurrentShowViewController] presentViewController:videoCoverVC animated:YES completion:nil];
    }];
    
    // 图片放大功能
    [[[cell.lookoverBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSMutableArray *items = @[].mutableCopy;
        NSInteger count;
        if(self.local_imagePaths.count > 9){
            count = 9;
        }else{
            count = self.local_imagePaths.count;
        }
        
        for (int i = 0; i < count; i++) {
            // Get the large image url
            NSString *url = [self.local_imagePaths[i] stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"];
            KSPhotoItem *item = [KSPhotoItem itemWithSourceView:cell.imageView imageUrl:[NSURL URLWithString:url]];
            [items addObject:item];
        }

        KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:indexPath.row];
        browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlack;
        [browser showFromViewController:self.hx_viewController.navigationController];
    }];
    
    return cell;
}

#pragma mark 长按响应方法
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longPress {
    //获取点击在collectionView的坐标
    CGPoint point=[longPress locationInView:self];
    //从长按开始
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath=[self indexPathForItemAtPoint:point];
        [self beginInteractiveMovementForItemAtIndexPath:indexPath];
    //长按手势状态改变
    } else if(longPress.state==UIGestureRecognizerStateChanged) {
        [self updateInteractiveMovementTargetPosition:point];
    //长按手势结束
    } else if (longPress.state==UIGestureRecognizerStateEnded) {
        [self endInteractiveMovement];
    //其他情况
    } else {
        [self cancelInteractiveMovement];
    }
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath {
    /* 两个indexpath参数, 分别代表源位置, 和将要移动的目的位置*/
    //-1 是为了不让最后一个可以交换位置
    if (proposedIndexPath.item == (self.local_imagePaths.count)) {
    //初始位置
        return originalIndexPath;
    } else {
        //-1 是为了不让最后一个可以交换位置
        if (originalIndexPath.item == (self.local_imagePaths.count)) {
            return originalIndexPath;
        }
        //      移动后的位置
        return proposedIndexPath;
    }
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"老位置：%ld  新位置：%ld",sourceIndexPath.item, destinationIndexPath.item);
    NSLog(@"更换前%@",self.local_imagePaths);
    //记录要移动的数据
    id object= self.local_imagePaths[sourceIndexPath.item];
    //删除要移动的数据
    [self.local_imagePaths removeObjectAtIndex:sourceIndexPath.item];
    //添加新的数据到指定的位置
    [self.local_imagePaths insertObject:object atIndex:destinationIndexPath.item];
    NSLog(@"更换后%@",self.local_imagePaths);
    self.model.local_imagePaths = self.local_imagePaths;
    [self reloadData];
}

@end
