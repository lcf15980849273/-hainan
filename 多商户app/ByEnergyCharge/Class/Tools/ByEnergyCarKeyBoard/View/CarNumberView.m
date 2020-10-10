
//
//  CarNumberView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "CarNumberView.h"
#import "CarNumberCollectionViewCell.h"

@interface CarNumberView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) CGFloat sc_cellHeight;
@property (nonatomic, assign) CGFloat sc_cellWidth;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableDictionary *textDictionary;
@property (nonatomic, assign) BOOL toBecome;
@end

@implementation CarNumberView

static NSString * identifier = @"CellID";
static NSString * identifier1 = @"LabelCellID";

- (instancetype)init {
    if (self = [super init]) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)byEnergyInitViews {
    self.sc_cellHeight = 45;
    self.sc_cellWidth = 32;
    [self addSubview:self.collectionView];
    [self.collectionView reloadData];
}

- (void)byEnergySetViewLayout {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
}


#pragma mark - set_and_get

- (NSMutableDictionary *)textDictionary {
    if (_textDictionary == nil) {
        _textDictionary = [[NSMutableDictionary alloc] init];
        [_textDictionary setObject:@"闽" forKey:@"0"];
    }
    return _textDictionary;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        //自动网格布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 5;
        //网格布局
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        //注册cell
        [_collectionView registerClass:[CarNumberCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier1];
        _collectionView.backgroundColor = [UIColor whiteColor];
        //设置数据源代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.clipsToBounds = NO;
    }
    return _collectionView;
}

#pragma mark - deleDate
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.carNumberModel.sections?:1;
}
//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.carNumberModel.items;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //根据identifier从缓冲池里去出cell
    if (indexPath.row == 2) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier1 forIndexPath:indexPath];
        if (cell.contentView.subviews.count == 0) {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
            ViewRadius(label, 4);
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(8, 8));
                make.centerX.equalTo(cell.mas_centerX).mas_offset(0);
                make.centerY.equalTo(cell.mas_centerY).mas_offset(0);
            }];
        }
        return cell;
    }else {
        __block CarNumberCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.tag = indexPath.item;
        [cell fillCellContent:[self.textDictionary objectForKey:NSStringFormat(@"%zd",indexPath.row)] isNewEnergyCar:self.isNewEnergyCar];
        kWeakSelf(self);
        cell.textFieldBlock = ^(NSString * _Nonnull text, NSInteger tag, BOOL isDel) {
            if (isDel) {
                weakself.index = [weakself forInArrFromIndex:tag toBefore:tag-1 str:@""];
                [weakself.textDictionary removeObjectForKey:NSStringFormat(@"%zd",weakself.index)];
            }else {
                if (text.length == 0) {
                    return;
                }
                [weakself.textDictionary setValue:byEnergyClearNilStr(text) forKey:NSStringFormat(@"%zd",tag)];
                weakself.index = [weakself forinArrFromIndex:tag toNext:tag+1 str:text];
            }
        };
        
        if (indexPath.item == 0 && self.toBecome == NO) {
            [[cell textField] becomeFirstResponder];
            self.toBecome = YES;
        }
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return CGSizeMake(16, self.sc_cellHeight);
    }
    return CGSizeMake(self.sc_cellWidth, self.sc_cellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat margin = (SCREENWIDTH- ((self.carNumberModel.items-1)*self.sc_cellWidth+16+(self.carNumberModel.items-1)*5))/2;
    return UIEdgeInsetsMake(0, margin, 0, margin);
}

- (void)setCarNumberModel:(CarNumberModel *)carNumberModel {
    _carNumberModel = carNumberModel;;
}

#pragma mark -----Action
- (NSInteger)forinArrFromIndex:(NSInteger)fromIndex toNext:(NSInteger )nextIndex str:(NSString *)str {
    NSArray *result = [self getCells];
    if (fromIndex < 0 || fromIndex >= self.carNumberModel.items) {
        return -1;
    }else{
        id cell = [result objectAtIndex:fromIndex];
        if ([cell isKindOfClass:[CarNumberCollectionViewCell class]]) {
            [cell textField].text = str;
        }
    }
    NSInteger k = 0;
    BOOL isHave = NO;
    for (NSInteger i = nextIndex; i < self.carNumberModel.items; i++) {
        id cell = [result objectAtIndex:i];
        if ([cell isKindOfClass:[CarNumberCollectionViewCell class]]) {
            if ([(CarNumberCollectionViewCell *)cell textField].text.length == 0) {
                k = i;
                [[cell textField] becomeFirstResponder];
                isHave = YES;
                break;
            }
        }
    }
    if (!isHave) {
        for (NSInteger i = 0; i < self.carNumberModel.items; i++) {
            id cell = [result objectAtIndex:i];
            if ([cell isKindOfClass:[CarNumberCollectionViewCell class]]) {
                if ([cell textField].text.length == 0) {
                    k = i;
                    [[cell textField] becomeFirstResponder];
                    isHave = YES;
                    break;
                }
            }
        }
    }
    if (!isHave) {
        [self endEditing:YES];
        return self.carNumberModel.items;
    }else
        return k;
}

- (NSInteger)forInArrFromIndex:(NSInteger)fromIndex toBefore:(NSInteger )beforeIndex str:(NSString *)str {
    NSArray *result = [self getCells];
    if (fromIndex < 0 || fromIndex >= self.carNumberModel.items || beforeIndex < -1) {
        return -1;
    }
    NSInteger k = 0;
    BOOL isHave = NO;
    UITextField *seletField;
    for (NSInteger i = fromIndex; i >= 0; i--) {
        id cell = [result objectAtIndex:i];
        if ([cell isKindOfClass:[CarNumberCollectionViewCell class]]) {
            if ([cell textField].text.length != 0) {
                k = i;
                seletField = [(CarNumberCollectionViewCell *)cell textField];
                [[cell textField] becomeFirstResponder];
                isHave = YES;
                break;
            }
        }
    }
    if (!isHave) {
        for (NSInteger i = self.carNumberModel.items - 1; i >= 0 ; i--) {
            id cell = [result objectAtIndex:i];
            if ([cell isKindOfClass:[CarNumberCollectionViewCell class]]) {
                if ([cell textField].text.length != 0) {
                    k = i;
                    seletField = [(CarNumberCollectionViewCell *)cell textField];
                    [[cell textField] becomeFirstResponder];
                    isHave = YES;
                    break;
                }
            }
        }
    }
    if (!isHave) {
        return -1;
    }else{
        seletField.text = str;
        return k;
    }
}

#pragma mark ----- Action

- (NSString *)text{
    NSString *text = @"";
    NSArray *result = [self getCells];
    for (NSInteger i = 0; i < result.count; i++) {
        id cell = [result objectAtIndex:i];
        if ([cell isKindOfClass:[CarNumberCollectionViewCell class]]) {
            text = [NSString stringWithFormat:@"%@%@", text, [cell textField].text];
        }
    }
    return text;
}

- (void)setIsNewEnergyCar:(BOOL)isNewEnergyCar {
    _isNewEnergyCar = isNewEnergyCar;
    self.carNumberModel.items = _isNewEnergyCar?9:8;
    if (!_isNewEnergyCar) {
        [self.textDictionary removeObjectForKey:@"8"];
    }
    kWeakSelf(self);
    if (self.toBecome) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakself.index = [weakself forinArrFromIndex:0 toNext:1 str:[weakself.textDictionary objectForKey:@"0"]];
        });
    }
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    
}

- (void)setCarNumber:(NSString *)carNumber {
    _carNumber = carNumber;
        for (NSInteger i = 0; i < carNumber.length; i++) {
            NSRange  range = NSMakeRange(i, 1);
            NSString *subStr = [carNumber substringWithRange:range];
            if (i < 2) {
                [self.textDictionary setValue:byEnergyClearNilStr(subStr) forKey:NSStringFormat(@"%zd",i)];
            }else {
                [self.textDictionary setValue:byEnergyClearNilStr(subStr) forKey:NSStringFormat(@"%zd",(i+1))];
            }
        }
    
}

- (NSArray *)getCells{
    NSArray *array = [self.collectionView visibleCells];
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)[self.collectionView indexPathForCell:obj1];
        NSIndexPath *path2 = (NSIndexPath *)[self.collectionView indexPathForCell:obj2];
        return [path1 compare:path2];
    }];
    return result;
}

@end
