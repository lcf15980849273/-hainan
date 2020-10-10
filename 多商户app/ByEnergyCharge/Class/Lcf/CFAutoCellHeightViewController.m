//
//  CFAutoCellHeightViewController.m
//  byCF
//
//  Created by 刘辰峰 on 2020/11/27.
//  Copyright © 2020 刘辰峰. All rights reserved.
//



/**
 在cell内t容不是很复杂的时候可使用这个控制器中cell根据约束返回高度的方法
 */
#import "CFAutoCellHeightViewController.h"
#import "CFAutoCellHeightCell.h"
@interface CFAutoCellHeightViewController()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@end

@implementation CFAutoCellHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注意点2
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:kCFAutoCellHeightCell bundle:nil] forCellReuseIdentifier:kCFAutoCellHeightCell];
}

#pragma mark - tableViewDelegate DataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CFAutoCellHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:kCFAutoCellHeightCell];
    cell.title = self.array[indexPath.row];
    return cell;
}

#pragma mark - Lazy
- (NSArray *)array {
    if (!_array) {
        _array = @[@"虽然能解决上面的问题，但这样的代码看起来很垃圾",@"虽然能解决上面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾",@"虽然能解决上面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾",@"虽然能解决上面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾",@"虽然能解决上面的问题，但这样的代然能解决上面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾面的问题，但这样的代码码看起来很垃圾",@"虽然能解决上面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾",@"虽然能解决上面的问题，但这样的代然能解决面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾上面的问题，但这样的代码码看起来很垃圾",@"虽然能解决上面的问题，但这样的代然能解面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾决上面的问题，但这样的代码码看起来很垃圾",@"虽然能解决上面的问题，但这样的代然能解决上面的问题，但面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾这样的代码码看起来很垃圾",@"虽然能解决上面的问题，但这样的代然能解决上面的问题，但这样的代面的问题，但这样的代然能解决上面的问题，但这样的代码码看起来很垃圾码码看起来很垃圾"];
    }
        return _array;
}
@end
