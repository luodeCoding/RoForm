//
//  NEFormDemoVC.m
//  TestNEPodSpecDemo
//
//  Created by roder on 2022/1/27.
//

#import "NEFormDemoVC.h"
#import "NECreateDemoViewModel.h"
#import "NEFormTableView.h"

@interface NEFormDemoVC ()
@property (nonatomic,strong) NEFormTableView *tableview;
@property (nonatomic,strong) NECreateDemoViewModel *viewModel;
@end

@implementation NEFormDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)initViews{
    self.title = @"创建俱乐部";
    // 初始化表单ViewModel
    _viewModel = [[NECreateDemoViewModel alloc] init];
    // 初始化表单tableView
    self.tableview = [[NEFormTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped models:self.viewModel.modelGroups];
    
    self.tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(NavigationContentTop, 0, 0, 0));
    }];
}

@end
