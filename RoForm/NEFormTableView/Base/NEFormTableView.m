//
//  NEFormTableView.m
//  NETools
//
//  Created by roder on 2022/1/26.
//

#import "NEFormTableView.h"

@interface NEFormTableView()<UITableViewDataSource,UITableViewDelegate,NEFormTableViewCellDelegate>
@end

@implementation NEFormTableView
- (void)awakeFromNib{
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style models:(NSArray<NSArray*>*)models {
    if ([super initWithFrame:frame style:style]) {
        self.modelGroups = models;
        self.backgroundColor = [UIColor clearColor];
        [self initSelf];
    }
    return self;
}

- (void)updateWithModels:(NSArray<NSArray*>*)models{
    self.modelGroups = models;
    self.backgroundColor = [UIColor clearColor];
    [self initSelf];
}

- (void)initSelf{
    self.backgroundColor = [UIColor clearColor];
    [self setAllowsSelection:NO];
    for (NSArray<NEFormTableViewCellModel*> *models in self.modelGroups) {
        for (NEFormTableViewCellModel *model in models) {
            [self registerNib:[UINib nibWithNibName:model.className bundle:[NSBundle mainBundle]] forCellReuseIdentifier:model.className];
        }
    }
    self.delegate = self;
    self.dataSource = self;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setSeparatorColor:[UIHelper lineViewBgColor]];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyboard)]];
}

- (void)cancelKeyboard{
    [self endEditing:YES];
}

- (void)heightDidChange:(NEFormTableViewCell *)cell{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath) {
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self layoutIfNeeded];
        [self.baseDelegate heightDidChange];
    }
}

#pragma mark delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NEFormTableViewCellModel *model = self.modelGroups[indexPath.section][indexPath.row];
    NEFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.className forIndexPath:indexPath];
    cell.model = model;
    cell.delegate = self;
    
    // 分割线逻辑
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIHelper lineViewBgColor];
    [cell addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(0);
        make.height.offset(0.5);
    }];
    NSArray<NEFormTableViewCellModel*> *models = self.modelGroups[indexPath.section];
    view.hidden = models.count == indexPath.row + 1;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelGroups[section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelGroups.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.modelGroups[indexPath.section][indexPath.row].height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc]init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.modelGroups.count == section + 1 ? 0 : 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIHelper backgroundColor];
    return view;
}

@end
