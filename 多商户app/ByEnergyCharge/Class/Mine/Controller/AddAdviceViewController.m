//
//  AddAdviceViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "AddAdviceViewController.h"
#import "BEnergyFeedBackBottomView.h"
#import "BEnergyFeedBackPoupView.h"
#import "BEnergyFeedBackViewModel.h"
#import "BEnergyFeedBackCallBackListModel.h"
#import "BEnergyFeedBackAddtionalCell.h"
#import "BEnergyFeedBackAdditionalListCell.h"
@interface AddAdviceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)BEnergyFeedBackBottomView *bootomView;
@property(nonatomic, strong)BEnergyFeedBackPoupView *poupView;
@property (nonatomic, strong) BEnergyFeedBackViewModel *FeedBackViewModel;
@property(nonatomic, strong)BEnergyFeedBackCallBackListModel *callBackListModel;
@end

@implementation AddAdviceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitViews];
    
    [self byEnergySetViewLayout];
    
    [self byEnergyInitViewModel];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergyInitViews {
    
    self.navigationItem.title = @"我的反馈";
    self.view.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#f6f6f6"];
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyFeedBackAddtionalCell bundle:nil] forCellReuseIdentifier:kBEnergyFeedBackAddtionalCell];
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyFeedBackAdditionalListCell bundle:nil] forCellReuseIdentifier:kBEnergyFeedBackAdditionalListCell];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#f6f6f6"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.loadEmptyType = SCLoadEmptyTypeDefalt;
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bootomView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillHide:)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

- (void)byEnergySetViewLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.bottom.equalTo(self.view).offset(-156);
    }];
    
    [self.bootomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(0);
        make.height.mas_offset(156);
    }];
}

- (void)byEnergyInitViewModel {
    
    RAC(self.FeedBackViewModel,feedbackId) = _RACObserve(self, feedBackId);
    
    ByEnergyWeakSekf
    [[[[self.FeedBackViewModel.hnFeedBackResoveCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.FeedBackViewModel.result) {
        }
        [HUDManager showStateHud:@"问题已解决" state:HUDStateTypeSuccess];
        [self.navigationController popViewControllerAnimated:YES];
        if (self.refreshFeedBackListDataBlock) {
            self.refreshFeedBackListDataBlock();
        }
    }];
    
    [[[[self.FeedBackViewModel.hnFeedBackAdditionalCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.FeedBackViewModel.result) {
        }
        [HUDManager showStateHud:@"感谢您的反馈" state:HUDStateTypeSuccess];
        [self.poupView viewHiden];
        [self.FeedBackViewModel.hnFeedBackCallListCommand execute:nil];
    }];
    
    
    [[[[self.FeedBackViewModel.hnFeedBackCallListCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.FeedBackViewModel.result) {
        }
        self.callBackListModel = self.FeedBackViewModel.value;
        [self.tableView reloadData];
        [self.tableView endRefreshing];
    }];
    
    self.tableView.viewModel = self.FeedBackViewModel;
    self.tableView.headerRefreshingBlock = ^{
        ByEnergyStrongSelf
        [self.FeedBackViewModel.hnFeedBackCallListCommand execute:nil];
    };
    
    self.tableView.footerRefreshingBlock = ^{
        ByEnergyStrongSelf
        [self.FeedBackViewModel.hnFeedBackCallListCommand execute:nil];
    };
    [self.tableView beginRefreshing];
    
}

#pragma mark ----- tableViewDelegate Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.callBackListModel.list.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        BEnergyFeedBackAddtionalCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyFeedBackAddtionalCell];
        cell.model = self.model;
        return cell;
    }else {
        BEnergyFeedBackAdditionalListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyFeedBackAdditionalListCell];
        cell.model = self.callBackListModel.list[indexPath.row - 1];
        return cell;
    }
}

#pragma mark ----- keyboardnotication

- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = kbHeight;
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.poupView.frame = CGRectMake(0.0f, -130, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.poupView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREENHEIGHT);
    }];
}

#pragma mark ----- LazyLoad
LCFLazyload(BEnergyFeedBackViewModel, FeedBackViewModel)
LCFLazyload(BEnergyFeedBackCallBackListModel, callBackListModel)

- (BEnergyFeedBackBottomView *)bootomView {
    if (!_bootomView) {
        _bootomView = [[BEnergyFeedBackBottomView alloc] initWithFrame:CGRectZero];
        ByEnergyWeakSekf
        [_bootomView setShowFeedBackPopViewBlock:^{
            ByEnergyStrongSelf
            [self.poupView viewShow];
        }];
        
        [_bootomView setResoveFeedBackBlock:^{
            ByEnergyStrongSelf
            [self.FeedBackViewModel.hnFeedBackResoveCommand execute:nil];
        }];
    }
    return _bootomView;
}

- (BEnergyFeedBackPoupView *)poupView {
    if (!_poupView) {
        _poupView = [[BEnergyFeedBackPoupView alloc] initWithFrame:CGRectZero];
        ByEnergyWeakSekf
        [_poupView setCommitAddtionalFeedBackBlock:^{
            ByEnergyStrongSelf
            if (self.poupView.contentTextView.inputTextView.text.length == 0) {
                [HUDManager showTextHud:@"请输入反馈内容"];return;
            }
            self.FeedBackViewModel.info = self.poupView.contentTextView.inputTextView.text;
            [self.FeedBackViewModel.hnFeedBackAdditionalCommand execute:nil];
            
        }];
    }
    return _poupView;
}
@end
