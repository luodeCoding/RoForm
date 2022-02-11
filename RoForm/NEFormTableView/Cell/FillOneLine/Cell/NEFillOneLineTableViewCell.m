//
//  NEFillOneLineTableViewCell.m
//  NETools
//
//  Created by roder on 2020/11/5.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFillOneLineTableViewCell.h"
#import "NEFillOneLineTableViewCellModel.h"
@interface NEFillOneLineTableViewCell() <QMUITextFieldDelegate>
@end
@implementation NEFillOneLineTableViewCell
@synthesize model = _model;

- (void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.textColor = [UIColor blackColor];
    self.contentTextField.textColor = [UIColor blackColor];
    self.unitLabel.textColor = [UIColor blackColor];
}

- (void)setModel:(NEFillOneLineTableViewCellModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    [self.necessaryImageView setHidden:!model.isNecessary];
    [self.contentTextField setEnabled:!model.isNotInputed];
    self.contentTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:model.contentPlaceHolderText attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    self.contentTextField.text = model.contentText;
    self.model.height = 48;
    self.contentTextField.delegate = self;
    self.contentTextField.keyboardType = model.inputKeyBoardType;
    self.contentTextField.text =  model.contentText;
    [self.contentTextField addTarget:self action:@selector(contentTextChange:) forControlEvents:UIControlEventEditingDidEnd];
    if (model.inputLimitNum > 0) {
        self.contentTextField.maximumTextLength = model.inputLimitNum;
    }
    self.unitLabel.hidden = YES;
    if (model.inputUnit.length > 0){
        self.unitLabel.hidden = NO;
        self.unitLabel.text = model.inputUnit;
    }
}

#pragma mark - 绑定改变model

- (void)contentTextChange:(UITextField *)textField{
    NEFillOneLineTableViewCellModel *thisModel = (NEFillOneLineTableViewCellModel *)_model;
    thisModel.contentText = textField.text;
    if (thisModel.inputLimitNum && textField.text.length > thisModel.inputLimitNum) {
        textField.text = [textField.text substringToIndex:thisModel.inputLimitNum];
        thisModel.contentText = textField.text;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NEFillOneLineTableViewCellModel *thisModel = (NEFillOneLineTableViewCellModel *)_model;
    if (thisModel.inputPointNum == 0) {
        return YES;
    }
    
    //只允许输入一个小数点
    if ([textField.text containsString:@"."] && [string isEqualToString:@"."]) {
        return NO;
    }
    //小数点不能为第一位
    if (textField.text.length == 0 && [string isEqualToString:@"."]) {
        return NO;
    }
    
    //限制小数点后只能多少位 thisModel.inputPointNum
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    
    [futureString  insertString:string atIndex:range.location];
    NSInteger flag=0;
    const NSInteger limited = thisModel.inputPointNum;//小数点后需要限制的个数
    for (int i = (int)(futureString.length - 1); i>=0; i--) {
        if ([futureString characterAtIndex:i] == '.') {
            if (flag > limited) {
                return NO;
            }
            break;
        }
        flag++;
    }
    return YES;
}

@end
