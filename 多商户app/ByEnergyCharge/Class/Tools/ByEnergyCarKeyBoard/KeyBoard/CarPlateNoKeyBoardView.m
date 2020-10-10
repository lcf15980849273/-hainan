//
//  CarPlateNoKeyBoardView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "CarPlateNoKeyBoardView.h"
#import "CarKeyBoardViewModel.h"
#import "CarPlateNoKeyBoardCell.h"

@interface CarPlateNoKeyBoardView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) CGFloat rz_cellHeight;
@property (nonatomic, assign) CGFloat rz_cellWidth;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CarKeyBoardViewModel *viewModel;

@end


@implementation CarPlateNoKeyBoardView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame {
    self.rz_cellHeight = 54;
    self.rz_cellWidth = MIN(60, SCREENWIDTH/10.f);
    frame = CGRectMake(0, 0, SCREENWIDTH, self.rz_cellHeight * 4 + SafeAreaBottomHeight + 10);
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.clipsToBounds = NO;
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"CFD5DB"];
        [self.collectionView registerClass:[CarPlateNoKeyBoardCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, 0, SCREENWIDTH, self.rz_cellHeight * 4 + SafeAreaBottomHeight + 10);
    self.collectionView.frame =  CGRectMake(0, 0, SCREENWIDTH, self.rz_cellHeight * 4 + 10);
    [self.collectionView reloadData];
}

- (CarKeyBoardViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CarKeyBoardViewModel alloc] init];
        [_viewModel sc_changeKeyBoardType:YES];
    }
    return _viewModel;
}

- (void)sc_changeKeyBoard:(BOOL)showProvince {
    _isProvince = showProvince;
    [self.viewModel sc_changeKeyBoardType:showProvince];
    
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.rz_cellWidth = MIN(60, SCREENWIDTH/([self.viewModel.dataSource[indexPath.section] count] > 10?[self.viewModel.dataSource[indexPath.section] count]:10));
    return CGSizeMake(self.rz_cellWidth, self.rz_cellHeight);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    NSArray *items = self.viewModel.dataSource[section];
    self.rz_cellWidth = MIN(60, SCREENWIDTH/(items.count > 10?items.count:10));
    CGFloat width = self.rz_cellWidth * items.count;
    
    CGFloat leftMargin = 0;
    if (width < collectionView.bounds.size.width) {
        leftMargin = (collectionView.bounds.size.width - width)/2.f; // 保证所有按钮居中
    }
    
    return UIEdgeInsetsMake(0, leftMargin, 0, leftMargin);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarPlateNoKeyBoardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CarKeyBoardCellModel *model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if (_isProvince && [model.text isEqualToString:self.selectProvince]) {
        model.isSelect = YES;
    }else {
        model.isSelect = NO;
    }
    cell.model = model;
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    cell.sc_clicked = ^(NSIndexPath * _Nonnull indexPath) {
        [weakSelf cellClickedIndexPath:indexPath];
    };
    return cell;
}

- (void)cellClickedIndexPath:(NSIndexPath *)indexPath {
    CarKeyBoardCellModel *model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    
    if (model.sc_isChangedKeyBoardBtnType) {
        [self.viewModel sc_changeKeyBoardType:!self.viewModel.isProvince];
        self.isProvince = self.viewModel.isProvince;
        [self.collectionView reloadData];
        return ;
    }
    if (self.sc_keyboardEditing) {
        self.sc_keyboardEditing(model.sc_isDeleteBtnType, model.text);
    }
}

@end
