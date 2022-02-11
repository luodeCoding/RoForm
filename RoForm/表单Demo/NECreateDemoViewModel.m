//
//  NECreateDemoViewModel.m
//  TestNEPodSpecDemo
//
//  Created by roder on 2022/1/27.
//

#import "NECreateDemoViewModel.h"
#import "NEFormTableView.h"
#import "NEImagePickTableViewCellModel.h"
#import "NESingleButtonTableViewCellModel.h"
#import "NEFillOneLineTableViewCellModel.h"
#import "NEFillDetailTableViewCellModel.h"
#import "NEDatePickTableViewCellModel.h"
#import "NEAddressPickTableViewCellModel.h"

#import "NEPlainTextTableViewCellModel.h"
#import "NECheckBoxTableViewCellModel.h"
#import "NESwitchTableViewCellModel.h"

@interface NECreateDemoViewModel ()

@property (nonatomic,strong) NEFormTableView *tableview;
@property (nonatomic,strong) NEImagePickTableViewCellModel *logoImagesModel;//logo图片
@property (nonatomic,strong) NEImagePickTableViewCellModel *norImagesModel;//俱乐部图片
@property (nonatomic,strong) NEFillOneLineTableViewCellModel *clubNameModel;//俱乐部名称
@property (nonatomic,strong) NEFillOneLineTableViewCellModel *contactPhoneModel;//联系电话
@property (nonatomic,strong) NEAddressPickTableViewCellModel *addressPickModel;//省市区
@property (nonatomic,strong) NEFillOneLineTableViewCellModel *signModel;//俱乐部签名
@property (nonatomic,strong) NEFillDetailTableViewCellModel *introduceModel;//详细介绍
@property (nonatomic,strong) NEDatePickTableViewCellModel *setupTimeModel;//成立时间
@property (nonatomic,strong) NEPlainTextTableViewCellModel *plainTextModel;//普通文本展示
@property (nonatomic,strong) NECheckBoxTableViewCellModel *checkBoxModel;//选择器
@property (nonatomic,strong) NESwitchTableViewCellModel *switchModel;//开关

@property (nonatomic,strong) NESingleButtonTableViewCellModel *createModel;//底部按钮

@end

@implementation NECreateDemoViewModel

- (NSArray<NSArray*>*)modelGroups{
    if (!_modelGroups) {
        // 根据需求添加不同的formCellModel
        _logoImagesModel = [[NEImagePickTableViewCellModel alloc] init];
        _logoImagesModel.title = @"上传俱乐部Logo";
        _logoImagesModel.mode = 1;
        _logoImagesModel.maxPhotoNum = 1;
        _logoImagesModel.isNecessary = YES;
        
        _norImagesModel = [[NEImagePickTableViewCellModel alloc] init];
        _norImagesModel.title = @"上传俱乐部图片";
        _norImagesModel.subTitle = @"第一张默认为封面图，支持上传多张，最多上传9张。";
        _norImagesModel.maxPhotoNum = 9;
        _norImagesModel.mode = 1;
        
        _clubNameModel = [[NEFillOneLineTableViewCellModel alloc] init];
        _clubNameModel.title = @"俱乐部名称";
        _clubNameModel.isNecessary = YES;
        _clubNameModel.contentPlaceHolderText = @"请填写俱乐部名称";
        _clubNameModel.inputLimitNum = 40;
              
        _addressPickModel = [[NEAddressPickTableViewCellModel alloc] init];
        _addressPickModel.title = @"所在地";
        _addressPickModel.isNecessary = YES;
        _addressPickModel.addressNamePlaceHolderText = @"请选择所在地";
              
        _contactPhoneModel = [[NEFillOneLineTableViewCellModel alloc] init];
        _contactPhoneModel.title = @"联系电话";
        _contactPhoneModel.isNecessary = YES;
        _contactPhoneModel.contentPlaceHolderText = @"请填写联系电话";
        _contactPhoneModel.inputLimitNum = 11;
        _contactPhoneModel.inputKeyBoardType = UIKeyboardTypeNumberPad;        
        
        _setupTimeModel = [[NEDatePickTableViewCellModel alloc] init];
        _setupTimeModel.title = @"成立时间";
        _setupTimeModel.date1_type = NEDatePickType_ymd;
        _setupTimeModel.isNecessary = NO;
        _setupTimeModel.isMin = NO;
        _setupTimeModel.isEdit = NO;
        _setupTimeModel.placeholderText1 = @"请选择成立时间";
        
        _signModel = [[NEFillOneLineTableViewCellModel alloc] init];
        _signModel.title = @"俱乐部签名";
        _signModel.contentPlaceHolderText = @"请填写俱乐部签名";
        _signModel.isNecessary = NO;
        _signModel.inputLimitNum = 30;
        
       
        _introduceModel = [[NEFillDetailTableViewCellModel alloc] init];
        _introduceModel.title = @"俱乐部介绍";
        _introduceModel.contentPlacehodlerText = @"请填写介绍";
        _introduceModel.isNecessary = NO;
        _introduceModel.limitNum = 256;
            
        _plainTextModel = [[NEPlainTextTableViewCellModel alloc]init];
        _plainTextModel.title = @"测试";
        _plainTextModel.isNecessary = YES;
        
        _checkBoxModel = [[NECheckBoxTableViewCellModel alloc]init];
        _checkBoxModel.title = @"您的性别？";
        _checkBoxModel.labels = @[@"男",@"女"];
        _checkBoxModel.isMulti = NO;
        _checkBoxModel.labels_selected = @[@"男"];
        _checkBoxModel.isNecessary = YES;
        
        _switchModel = [[NESwitchTableViewCellModel alloc]init];
        _switchModel.title = @"开关按钮";
        _switchModel.isNecessary = YES;
        _switchModel.switchOn = YES;
        
        _createModel = [[NESingleButtonTableViewCellModel alloc] init];
        UIButton *createBtn = [[UIButton alloc] init];
        [createBtn setTitle:@"立即创建" forState:UIControlStateNormal];
        [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [createBtn setBackgroundColor:[UIColor redColor]];
        [createBtn addTarget:self action:@selector(tapCreateButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        _createModel.button = createBtn;
            
         self.modelGroups = @[@[_logoImagesModel],
                              @[_norImagesModel],
                              @[_clubNameModel,_addressPickModel,_contactPhoneModel,_setupTimeModel,],
                              @[_signModel,_introduceModel],
                              @[_plainTextModel,_checkBoxModel],
                              @[_switchModel],
                              @[_createModel]];
        
    }
        return _modelGroups;
}

- (void)tapCreateButtonEvent {
    // 点击创建时校验
    if (!_logoImagesModel.local_imagePaths.count) {
//        [[TXBaseViewController recursiveFindCurrentShowViewController] showErrorTipsString:@"请上传俱乐部Logo"];
        return;
    }
      
    if (!_clubNameModel.contentText || [_clubNameModel.contentText isEqualToString:@""]) {
//        [[TXBaseViewController recursiveFindCurrentShowViewController] showErrorTipsString:@"请输入俱乐部名称"];
        return;
    }
    
    if(_clubNameModel.contentText.length > 20){
//        [[TXBaseViewController recursiveFindCurrentShowViewController] showErrorTipsString:@"俱乐部名称为20个字以内"];
        return;
    }
 
    if (!_addressPickModel.provinceLabel) {
//        [[TXBaseViewController recursiveFindCurrentShowViewController] showErrorTipsString:@"请选择所在地"];
        return;
    }
    
   if (!_contactPhoneModel.contentText || [_contactPhoneModel.contentText isEqualToString:@""]) {
//        [[TXBaseViewController recursiveFindCurrentShowViewController] showErrorTipsString:@"请填写联系电话"];
        return;
      }
}

@end
