//
//  NEVideoCoverVC.h
//  NETools
//
//  Created by roder on 2021/1/28.
//  Copyright © 2021 roder. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VideoCoverBlock)();

@interface NEVideoCoverVC : UIViewController
@property (nonatomic,strong) NSURL *videoUrl;
@property (nonatomic,strong) NSString *local_videoThumbPath;
@property (nonatomic, copy) VideoCoverBlock videoCoverBlock;
@end

NS_ASSUME_NONNULL_END
