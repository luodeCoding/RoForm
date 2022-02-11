//
//  NEFormTableViewCellModel.h
//  NETools
//
//  Created by roder on 2022/1/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEFormTableViewCellModel : NSObject
@property (nonatomic, copy) NSString *className;
@property (nonatomic,assign) CGFloat height;
@end

NS_ASSUME_NONNULL_END
