//
//  GuideFigureShowViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/31.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "GuideFigureShowViewController.h"

@interface GuideFigureShowViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation GuideFigureShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置界面
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    scrollView.contentSize = CGSizeMake(self.images.count * SCREENWIDTH, SCREENHEIGHT);
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < self.images.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT);
        [btn setBackgroundImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateHighlighted];
        UIButton *closebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closebtn setTitle:@"立即体验" forState:UIControlStateNormal];
        [closebtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [closebtn setBackgroundImage:[[UIImage imageNamed:@"btn_enter_n.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8,8,8,8)] forState:UIControlStateNormal];
        [closebtn setBackgroundImage:[[UIImage imageNamed:@"btn_enter_s.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8,8,8,8)] forState:UIControlStateHighlighted];
        [closebtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [closebtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        closebtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-110)/2.0, [UIScreen mainScreen].bounds.size.height-100, 110, 27);
        if (i == self.images.count - 1) {
            [closebtn addTarget:self action:@selector(clickLastBtn) forControlEvents:UIControlEventTouchUpInside];
            [btn addSubview:closebtn];
        }
        [scrollView addSubview:btn];
    }
    
    /**
     UIPageControl
     */
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.originY, SCREENWIDTH, 20)];
    self.pageControl.enabled = NO;
    self.pageControl.numberOfPages = self.images.count;
    self.pageControl.currentPageIndicatorTintColor = self.currentPageColor;
    self.pageControl.pageIndicatorTintColor = self.otherPageColor;
    [self.view addSubview:self.pageControl];
}
- (void)clickLastBtn
{
    if (self.clickLastPage) {
        self.clickLastPage();
    }
}


#pragma mark - scrollview delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / SCREENWIDTH;
    
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
