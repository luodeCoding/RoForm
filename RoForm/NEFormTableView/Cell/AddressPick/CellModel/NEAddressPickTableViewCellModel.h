//
//  NEAddressPickTableViewCellModel.h
//  NETools
//
//  Created by roder on 2020/11/9.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFormTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEAddressPickTableViewCellModel : NEFormTableViewCellModel
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isNecessary;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *addressNamePlaceHolderText;

@property (copy, nonatomic) NSString *provinceLabel;
@property (copy, nonatomic) NSString *cityLabel;
@property (copy, nonatomic) NSString *areaLabel;

@property (copy, nonatomic) NSString *provinceCode;
@property (copy, nonatomic) NSString *cityCode;
@property (copy, nonatomic) NSString *areaCode;

@end

NS_ASSUME_NONNULL_END
