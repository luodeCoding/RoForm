//
//  NEPlainTextTableViewCell.m
//  NETools
//
//  Created by roder on 2020/12/21.
//  Copyright © 2020 roder. All rights reserved.
//

#import "NEPlainTextTableViewCell.h"
#import "NEPlainTextTableViewCellModel.h"
@implementation NEPlainTextTableViewCell


@synthesize model = _model;

- (void)setModel:(NEPlainTextTableViewCellModel *)model{
    
    _model = model;
    self.plaintext.textColor = [UIHelper mainTextColor];
    self.plaintext.text = model.title;
    [self.necessaryImageView setHidden:!model.isNecessary];
    self.model.height = 48;
}



- (CGFloat)heightWithText:(NSString *)text {
    if (text.length == 0 || text == nil) {
        return 0;
    }
    CGSize size = CGSizeZero;
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect frame = [text boundingRectWithSize:CGSizeMake(MOMENTS_WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
    size = CGSizeMake(frame.size.width, frame.size.height + 1);
    return ceil(size.height) + font.ascender + font.descender;
}
@end
