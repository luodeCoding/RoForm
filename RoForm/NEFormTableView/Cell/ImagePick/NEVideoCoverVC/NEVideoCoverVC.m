//
//  NEVideoCoverVC.m
//  NETools
//
//  Created by roder on 2021/1/28.
//  Copyright © 2021 roder. All rights reserved.
//

#import "NEVideoCoverVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "SliderView.h"
#import "UIHelper.h"
#import "UIView+Custom.h"

@interface NEVideoCoverVC ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *coverView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *videoDisplayView;
@property (weak, nonatomic) IBOutlet UIView *bottomImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *coverImageHeight;
@property (nonatomic,assign) CGFloat videoImageWidth;// 底部固定帧图片的宽度
@property (nonatomic,assign) CGFloat videoLength; // 视频长度
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayer *player1;
@property (nonatomic,assign) Float64 cutenttime;

@property (nonatomic,strong) SliderView *sliderView;
@property (nonatomic,strong) NSMutableArray *imagesArray;
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;

@end

@implementation NEVideoCoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    _scrollView.delegate = self;
    _scrollView.layer.masksToBounds = NO;
    
    _scrollView.minimumZoomScale = 1.f;
    _scrollView.maximumZoomScale = 10.f;
    _scrollView.zoomScale = 1.f;
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    _scrollView.contentInset = UIEdgeInsetsZero;

    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    
    _coverImageHeight.constant = MOMENTS_VIDEO_HEIGHT;
    _videoImageWidth = ([UIScreen mainScreen].bounds.size.width -40)/8.0;
    [self getvideoLendth];// 获取视频时长
    [self setupBottomView];// 初始化bottomview
    self.productImageView.image = [self thumbnailImageForVideoWithTIme:0];
    [self playWithUrl:self.videoUrl];
}

#pragma mark - event
- (IBAction)cancelButtonEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sureButtonEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.videoCoverBlock) {
        [UIImagePNGRepresentation([self getmakeImageWithView:self.coverView andWithSize:self.coverView.size]) writeToFile:self.local_videoThumbPath atomically:YES];
        self.videoCoverBlock();
    }
}

- (UIImage *)getmakeImageWithView:(UIView *)view andWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Handle
/** 播放视频 */
- (void)playWithUrl:(NSURL *)url{
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    _player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = self.videoDisplayView.bounds;
    playerLayer.contentsGravity = AVLayerVideoGravityResizeAspect;
    // 添加到imageview的layer上
    [self.videoDisplayView.layer addSublayer:playerLayer];
    [_player play];
    [_player pause];
    
    AVPlayerItem *playerItem1 = [AVPlayerItem playerItemWithURL:url];
    _player1 = [AVPlayer playerWithPlayerItem:playerItem1];
    AVPlayerLayer *playerLayer1 = [AVPlayerLayer playerLayerWithPlayer:_player1];
    playerLayer1.frame = self.sliderView.bounds;
    playerLayer1.contentsGravity = AVLayerVideoGravityResizeAspect;
    [self.sliderView.layer addSublayer:playerLayer1];
    [_player1 play];
    [_player1 pause];
    
    self.videoDisplayView.hidden = YES;
}

- (void)setupBottomView
{
    for (int i =0; i<7;i++) {
        UIImage *image1=[self thumbnailImageForVideoWithTIme:i*(_videoLength/8.0)];
        [self.imagesArray addObject:image1];
    }
    // 放最后一帧图片
    UIImage *image1=[self thumbnailImageForVideoWithTIme:_videoLength];
    [self.imagesArray addObject:image1];
    
    // 放所有图片
    [self.imagesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageIV=[[UIImageView alloc] initWithFrame:CGRectMake(_videoImageWidth*idx, 0, _videoImageWidth, _videoImageWidth)];
        [imageIV setImage:self.imagesArray[idx]];
        [self.bottomImageView addSubview:imageIV];
    }];
    
    [self.bottomImageView bringSubviewToFront:self.sliderView];
}
/** 获取视频时长
 */
- (void)getvideoLendth
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.videoUrl options:nil];
    CMTime times= [asset duration];
    _videoLength=(CGFloat)times.value/times.timescale;
}

/**
 *  通过videoURL获得图片
 *
 */
- (UIImage*) thumbnailImageForVideoWithTIme:(Float64)i {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.videoUrl options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(i, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
    
    return thumbImg;
    
}

#pragma -mark- ======================observeValue======================
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"center"]) {
        
        CGFloat x=self.sliderView.center.x;
        CGFloat scale=(x-_videoImageWidth/2.0)/(self.view.frame.size.width-_videoImageWidth);
        NSLog(@"--===--%f",scale*_videoLength);
        NSLog(@"===++-%d",_player.currentTime.timescale);
        CMTime time = CMTimeMakeWithSeconds(scale*_videoLength, 600);
        [_player1 seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
        [_player seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
        self.cutenttime = scale * _videoLength;
        self.productImageView.image = [self thumbnailImageForVideoWithTIme:self.cutenttime];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {

    }
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.productImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [self.scrollView setZoomScale:scale animated:NO];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return nil;
}

#pragma mark - lazy
- (SliderView *)sliderView
{
    if (!_sliderView) {
        _sliderView=[SliderView new];
        _sliderView.frame=CGRectMake(-5, -5, _videoImageWidth+10, _videoImageWidth+10);
        _sliderView.layer.borderWidth=2.0;
        _sliderView.layer.borderColor= [UIColor yellowColor].CGColor;
        [self.bottomImageView addSubview:_sliderView];
        [_sliderView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _sliderView;
}

- (NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _imagesArray;
}

@end
