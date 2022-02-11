//
//  NECheckBoxTableViewCellModel.h
//  NETools
//
//  Created by roder on 2020/12/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NECheckBoxTableViewCellModel : NEFormTableViewCellModel
@property (nonatomic,strong) RACSubject * seletSub;;
@property (assign, nonatomic) BOOL isNecessary;
@property (nonatomic,strong) NSString *title;
//是否多选
@property (nonatomic,assign) BOOL isMulti;
//最多选num
@property (nonatomic,assign) NSInteger maxNum;
//标签
@property (nonatomic,strong) NSArray<NSString*> *labels;
//标签 已选中
@property (nonatomic,strong) NSArray<NSString*> *labels_selected;

@end

NS_ASSUME_NONNULL_END
