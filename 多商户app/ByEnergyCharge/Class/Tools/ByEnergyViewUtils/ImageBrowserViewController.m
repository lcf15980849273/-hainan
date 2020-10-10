//
//  ImageBrowserViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/18.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "ImageBrowserViewController.h"
#import "FSActionSheet.h"

@interface ImageBrowserViewController ()<UIScrollViewDelegate,ImageBrowserViewDelegate>{
    
    NSMutableArray *_subViewArray;//scrollView的所有子视图
}

/** 背景容器视图 */
@property(nonatomic,strong) UIScrollView *scrollView;

/** 外部操作控制器 */
@property (nonatomic,weak) UIViewController *handleVC;

/** 图片浏览方式 */
@property (nonatomic,assign) ImageBrowserVCType type;

/** 图片数组 */
@property (nonatomic,strong) NSArray *imagesArray;

/** 初始显示的index */
@property (nonatomic,assign) NSUInteger index;

/** 圆点指示器 */
@property(nonatomic,strong) UIPageControl *pageControl;

/** 记录当前的图片显示视图 */
@property(nonatomic,strong) ImageBrowserView *photoView;

@property (nonatomic, assign) BOOL hasShowedFistView;

/**
 *  ActionSheet的otherbuttontitles
 */
@property (nonatomic , strong) NSArray  *actionOtherButtonTitles;
/**
 *  ActionSheet的title
 */
@property (nonatomic , strong) NSString  *actionSheetTitle;
/**
 *  actionSheet的取消按钮title
 */
@property (nonatomic , strong) NSString  *actionSheetCancelTitle;
/**
 *  actionSheet的高亮按钮title
 */
@property (nonatomic , strong) NSString  *actionSheetDeleteButtonTitle;

/**
 * indexLabel显示位置
 */
@property (nonatomic , strong) UILabel  *indexLabel;

@end

@implementation ImageBrowserViewController

-(instancetype)init{
    
    self=[super init];
    if (self) {
        _subViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
    
    
    //去除自动处理
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置contentSize
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.imagesArray.count, 0);
    
    for (int i = 0; i < self.imagesArray.count; i++) {
        [_subViewArray addObject:[NSNull class]];
    }
    
    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width*self.index, 0);//此句代码需放在[_subViewArray addObject:[NSNull class]]之后，因为其主动调用scrollView的代理方法，否则会出现数组越界
    
    if (self.imagesArray.count==1) {
        _pageControl.hidden=YES;
    }else{
        self.pageControl.currentPage=self.index;
    }
    [self loadPhote:self.index];//显示当前索引的图片
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCurrentVC:)];
    [self.view addGestureRecognizer:tap];//为当前view添加手势，隐藏当前显示窗口
    
    self.indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 15, 40, SCREENWIDTH, 30)];
    self.indexLabel.font = ByEnergyRegularFont(20);
    self.indexLabel.textColor = UIColor.whiteColor;
    [self.view addSubview:self.indexLabel];
    
}

-(void)hideCurrentVC:(UIGestureRecognizer *)tap{
    [self hideScanImageVC];
}

#pragma mark - 显示图片
-(void)loadPhote:(NSInteger)index{
    
    if (index<0 || index >=self.imagesArray.count) {
        return;
    }
    id currentPhotoView = [_subViewArray objectAtIndex:index];
    if (![currentPhotoView isKindOfClass:[ImageBrowserView class]]) {
        //url数组或图片数组
        CGRect frame = CGRectMake(index*_scrollView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        if ([[self.imagesArray firstObject] isKindOfClass:[UIImage class]]) {
            ImageBrowserView *photoV = [[ImageBrowserView alloc] initWithFrame:frame withPhotoImage:[self.imagesArray objectAtIndex:index] withHasShowedFistView:_hasShowedFistView];
            photoV.delegate = self;
            [self.scrollView insertSubview:photoV atIndex:0];
            [_subViewArray replaceObjectAtIndex:index withObject:photoV];
            self.photoView=photoV;
        }else if ([[self.imagesArray firstObject] isKindOfClass:[NSString class]]){
            ImageBrowserView *photoV = [[ImageBrowserView alloc] initWithFrame:frame withPhotoUrl:[self.imagesArray objectAtIndex:index] withHasShowedFistView:_hasShowedFistView];
            photoV.delegate = self;
            [self.scrollView insertSubview:photoV atIndex:0];
            [_subViewArray replaceObjectAtIndex:index withObject:photoV];
            self.photoView=photoV;
        }
        _hasShowedFistView = YES;
    }
}

#pragma mark - 生成显示窗口
+(void)show:(UIViewController *)handleVC type:(ImageBrowserVCType)type index:(NSUInteger)index imagesBlock:(NSArray *(^)())imagesBlock completion:(void (^)(ImageBrowserViewController *))completion{
    
    NSArray *photoModels = imagesBlock();//取出相册数组
    
    if(photoModels == nil || photoModels.count == 0) {
        return;
    }
    
    ImageBrowserViewController *imgBrowserVC = [[self alloc] init];
    
    if(index >= photoModels.count){
        return;
    }
    
    imgBrowserVC.index = index;
    
    imgBrowserVC.imagesArray = photoModels;
    
    imgBrowserVC.type =type;
    
    imgBrowserVC.handleVC = handleVC;
    
    [imgBrowserVC show]; //展示
    completion(imgBrowserVC);
}

/** 真正展示 */
-(void)show{
    
    switch (_type) {
        case ImageBrowserVCTypePush://push
            
            [self pushPhotoVC];
            
            break;
        case ImageBrowserVCTypeModal://modal
            
            [self modalPhotoVC];
            
            break;
            
        case ImageBrowserVCTypeZoom://zoom
            
            [self zoomPhotoVC];
            
            break;
            
        default:
            break;
    }
}

/** push */
-(void)pushPhotoVC{
    
    [_handleVC.navigationController pushViewController:self animated:YES];
}


/** modal */
-(void)modalPhotoVC{
    
    [_handleVC presentViewController:self animated:YES completion:nil];
}

/** zoom */
-(void)zoomPhotoVC{
    
    //拿到window
    UIWindow *window = _handleVC.view.window;
    
    if(window == nil){
        NSLog(@"错误：窗口为空！");
        return;
    }
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    [window addSubview:self.view]; //添加视图
    
    [_handleVC addChildViewController:self]; //添加子控制器
}

#pragma mark - 隐藏当前显示窗口
-(void)hideScanImageVC{
    
    switch (_type) {
        case ImageBrowserVCTypePush://push
            
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
        case ImageBrowserVCTypeModal://modal
            
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
            
        case ImageBrowserVCTypeZoom://zoom
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
            break;
            
        default:
            break;
    }
}

- (void)hideScanImageVC:(void (^)(BOOL))completion{
    [self hideScanImageVC];
    completion(YES);
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (page<0||page>=self.imagesArray.count) {
        return;
    }
    self.pageControl.currentPage = page;
    self.indexLabel.text = NSStringFormat(@"%ld/%lu",(long)page + 1,(unsigned long)self.imagesArray.count);
    for (UIView *view in scrollView.subviews) {
        if ([view isKindOfClass:[ImageBrowserView class]]) {
            ImageBrowserView *photoV=(ImageBrowserView *)[_subViewArray objectAtIndex:page];
            if (photoV!=self.photoView) {
                [self.photoView.scrollView setZoomScale:1.0 animated:YES];
                self.photoView=photoV;
            }
        }
    }
    
    [self loadPhote:page];
}

#pragma mark - PhotoViewDelegate
-(void)tapHiddenPhotoView{
    [self hideScanImageVC];//隐藏当前显示窗口
}

- (void)handleLongPressGestureToPhotoView:(UIView *)browserView{
    FSActionSheet *actionSheet = [[FSActionSheet alloc] initWithTitle:self.actionSheetTitle delegate:nil cancelButtonTitle:self.actionSheetCancelTitle highlightedButtonTitle:self.actionSheetDeleteButtonTitle otherButtonTitles:self.actionOtherButtonTitles];
    __weak typeof(self) weakSelf = self;
    // 展示并绑定选择回调
    [actionSheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
        if (_delegate && [_delegate respondsToSelector:@selector(photoBrowser:clickActionSheetIndex:currentImageIndex:)]) {
            [weakSelf.delegate photoBrowser:(ImageBrowserView *)browserView clickActionSheetIndex:selectedIndex currentImageIndex:weakSelf.pageControl.currentPage];
        }
    }];
}

#pragma mark - 懒加载
-(UIScrollView *)scrollView{
    
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _scrollView.delegate=self;
        _scrollView.pagingEnabled=YES;
        _scrollView.contentOffset=CGPointZero;
        //设置最大伸缩比例
        _scrollView.maximumZoomScale=3;
        //设置最小伸缩比例
        _scrollView.minimumZoomScale=1;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (_pageControl==nil) {
        UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-40, SCREENWIDTH, 30)];
        bottomView.backgroundColor=[UIColor clearColor];
        _pageControl = [[UIPageControl alloc] initWithFrame:bottomView.bounds];
        _pageControl.currentPage = self.index;
        _pageControl.numberOfPages = self.imagesArray.count;
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:235 green:235 blue:235 alpha:0.6];
        [bottomView addSubview:_pageControl];
        [self.view addSubview:bottomView];
    }
    return _pageControl;
}


#pragma mark-----

/**
 *  初始化底部ActionSheet弹框数据
 *
 *  @param title                  ActionSheet的title
 *  @param delegate               XLPhotoBrowserDelegate
 *  @param cancelButtonTitle      取消按钮文字
 *  @param deleteButtonTitle      删除按钮文字
 *  @param otherButtonTitles      其他按钮数组
 */
- (void)setActionSheetWithTitle:(nullable NSString *)title delegate:(nullable id<ImageBrowserViewControllerDelegate>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle deleteButtonTitle:(nullable NSString *)deleteButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitle, ...
{
    NSMutableArray *otherButtonTitlesArray = [NSMutableArray array];
    NSString *buttonTitle;
    va_list argumentList;
    if (otherButtonTitle) {
        [otherButtonTitlesArray addObject:otherButtonTitle];
        va_start(argumentList, otherButtonTitle);
        while ((buttonTitle = va_arg(argumentList, id))) {
            [otherButtonTitlesArray addObject:buttonTitle];
        }
        va_end(argumentList);
    }
    self.actionOtherButtonTitles = otherButtonTitlesArray;
    self.actionSheetTitle = title;
    self.actionSheetCancelTitle = cancelButtonTitle;
    self.actionSheetDeleteButtonTitle = deleteButtonTitle;
    if (delegate) {
        self.delegate = delegate;
    }
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
