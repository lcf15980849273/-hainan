//
//  CFYYViewController.m
//  byCF
//
//  Created by 刘辰峰 on 2020/4/18.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import "CFYYViewController.h"
//#import "YYText.h"
//#import "CFYYLabelTestViewController.h"
static NSString *CellTableIndentifier = @"CellTableIdentifier";

#define testString @"YYTxt学习测试之对这个世界如果你有太"
#define valueString @"如果你有太"
@interface CFYYViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *listDataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CFYYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
}

- (void)initDataAndViews {
    self.title = @"YYText";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)addtitle:(NSString *)str imageStr:(NSString *)imageStr {
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
    }
    
//    YYLabel *label = [[YYLabel alloc] initWithFrame:CGRectMake(15, 10, self.view.frame.size.width, 40)];
//    if (indexPath.row == 0) {
//        label.text = self.listDataArray[indexPath.row];
//    }else {
//        label.attributedText = self.listDataArray[indexPath.row];
//        label.font = [UIFont systemFontOfSize:18];
//    }
//
//    //文本高亮设置了YYHightLight会走这个回调
//    label.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        YYTextHighlight *highlight = [containerView valueForKeyPath:@"_highlight"];
//        NSLog(@"--------%@",highlight.userInfo);
//    };
//    [cell.contentView addSubview:label];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.row) {
//        case 0:
//            [self.navigationController pushViewController:[CFYYLabelTestViewController new] animated:YES];
//            break;
//
//        default:
//            break;
//    }
//}

#pragma mark - Method
/*字体、颜色、文字间距*/
- (NSMutableAttributedString *)yyWithFontColorSpacing {
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:testString];
    NSRange range = [[text string] rangeOfString:valueString];
//    [text yy_setFont:[UIFont systemFontOfSize:18] range:range];
//    [text yy_setColor:[UIColor redColor] range:range];
//    //文字间距
//    [text yy_setKern:@(2) range:range];
    return text;
}

/*文字描边(空心字)*/
- (NSMutableAttributedString *)yyWithStroke {
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:testString];
    NSRange range = [[text string] rangeOfString:valueString options:NSCaseInsensitiveSearch];
//    [text yy_setStrokeColor:[UIColor redColor] range:range];
//    [text yy_setStrokeWidth:@(3) range:range];
    return text;
}

/*删除样式、下划线*/
- (NSMutableAttributedString *)yyWithDeleteUnderLine {

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:testString];
    NSRange range = [[text string] rangeOfString:valueString options:NSCaseInsensitiveSearch];
//    YYTextDecoration *decoration = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle
//                                                                   width:@(2)
//                                                                   color:[UIColor redColor]];
//    //删除样式
//    [text yy_setTextStrikethrough:decoration range:range];
//    //下划线
//    [text yy_setTextUnderline:decoration range:range];
    return text;
}

/*边框*/
- (NSMutableAttributedString *)yyWithBorder {
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:testString];
    NSRange range = NSMakeRange(5, 3);
//    //边框
//    YYTextBorder *border = [YYTextBorder new];
//    border.cornerRadius = 2;
//    border.strokeWidth = 0.5;
//    border.strokeColor = [UIColor redColor];
//    border.insets = UIEdgeInsetsMake(-1, -1, -1, -1);
//    border.lineStyle = YYTextLineStyleSingle;
//    [text yy_setTextBorder:border range:range];
    return text;
}

/*阴影*/
- (NSMutableAttributedString *)yyWithShadow {
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:testString];
    NSRange range = [[text string] rangeOfString:valueString options:NSCaseInsensitiveSearch];
    //阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[UIColor redColor]];
    [shadow setShadowBlurRadius:1.0];
    [shadow setShadowOffset:CGSizeMake(2, 2)];
//    [text yy_setShadow:shadow range:range];
    return text;
}

/*简单文本高亮*/
- (NSMutableAttributedString *)yyWithHighLight {
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:testString];
//    NSRange range = [[text string] rangeOfString:valueString options:NSCaseInsensitiveSearch];
//    YYTextHighlight *fromhight = [YYTextHighlight highlightWithBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]];
//    fromhight.userInfo = @{@"key":@"fromName"};
//    YYTextHighlight *toHight = [YYTextHighlight highlightWithBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]];
//    toHight.userInfo = @{@"key":@"toName"};
//    [text yy_setTextHighlight:fromhight range:range];
//    [text yy_setColor:[UIColor redColor] range:range];
//    [text yy_setTextHighlight:toHight range:NSMakeRange(0, 4)];
//    [text yy_setColor:[UIColor redColor] range:NSMakeRange(0, 4)];
//    text.yy_lineSpacing = 1;
    

//    [text yy_setTextHighlightRange:range
//                             color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
//                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
//                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
//                         }];
    return text;
}

#pragma mark - lazyLoad
- (NSArray *)listDataArray {
    if (!_listDataArray) {
        _listDataArray = @[@"YYLabel实现图文混排",[self yyWithFontColorSpacing],[self yyWithStroke],[self yyWithDeleteUnderLine],[self yyWithBorder],
                           [self yyWithShadow],[self yyWithHighLight]];
    }
    return _listDataArray;
}
@end
