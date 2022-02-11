//
//  NEFillDetailTableViewCell.m
//  NETools
//
//  Created by roder on 2020/11/5.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEFillDetailTableViewCell.h"
#import "NEFillDetailTableViewCellModel.h"

@interface NEFillDetailTableViewCell()<UITextViewDelegate, QMUITextViewDelegate>
@property (nonatomic,strong) QMUITextView *textView;
@end;

@implementation NEFillDetailTableViewCell
@synthesize model = _model;


- (void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.textColor = [UIHelper mainTextColor];
}

- (void)setModel:(NEFillDetailTableViewCellModel *)model{
    _model = model;
    
    [self initViews];
    if (!model.limitNum) {
        model.limitNum = 256;
    }
    self.titleLabel.text = model.title;
    [self.necessaryImageView setHidden:!model.isNecessary];
    self.textView.placeholderColor = [UIColor grayColor];
    self.textView.placeholder = model.contentPlacehodlerText;
    self.textView.text = model.contentText;
    self.textView.font = [UIFont systemFontOfSize:16];
    self.countLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.textView.text.length, model.limitNum];
    self.model.height = model.limitNum > 100 ? 158 : 100;
}

- (void)initViews{
    if (!_textView) {
        _textView = [[QMUITextView alloc] init];
    }
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.textColor = [UIHelper mainTextColor];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.delegate = self;
    NEFillDetailTableViewCellModel *model = (NEFillDetailTableViewCellModel *)self.model;
    [self.contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(6);
        make.trailing.equalTo(self.contentView).offset(-SIDE_DISTANCE);
        make.leading.equalTo(self.contentView).offset(SIDE_DISTANCE + 6);
        make.bottom.equalTo(self.countLabel.mas_top).offset(-4);
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    NEFillDetailTableViewCellModel *model = (NEFillDetailTableViewCellModel *)self.model;
    if (textView.text.length > model.limitNum) {
        textView.text = [textView.text substringToIndex:model.limitNum];
    }
    model.contentText = textView.text;
    self.countLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)textView.text.length, model.limitNum];
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    NEFillDetailTableViewCellModel *model = (NEFillDetailTableViewCellModel *)self.model;
//    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
//    if (str.length > model.limitNum) {
//        return NO;
//    }
//    return YES;
//}

@end
