//
//  CFRacTestViewController.m
//  byCF
//
//  Created by 刘辰峰 on 2020/11/21.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import "CFRacTestViewController.h"

@interface CFRacTestViewController ()
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, copy) NSString *strting;
@property (weak, nonatomic) IBOutlet UITextField *amountTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *aggainPasswordTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation CFRacTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self loginTest];
    
//    [self racContact];
    
    NSString *str = @"123456";
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

        [subscriber sendNext:str];
        return [RACDisposable disposableWithBlock:^{

        }];
    }];

   

    
    
}

- (void)dealloc {
    
}

#pragma mark - RACScheduler
- (void)ractime {
    
}
#pragma mark -racContact
- (void)racContact {
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id subscriber) {
        [subscriber sendNext:@"我恋爱啦"];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id subscriber) {
        [subscriber sendNext:@"我结婚啦"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [[signalA concat:signalB] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

#pragma mark - rac登录测试
- (void)loginTest {
    
    RACSignal *amountSignal = [self textFiledSignal:self.amountTextFiled];
    RACSignal *passwordSignal = [self textFiledSignal:self.passwordTextFiled];
    RACSignal *aggainPasswordSignal = [self textFiledSignal:self.aggainPasswordTextFiled];

    @weakify(self)
    [[[RACSignal combineLatest:@[amountSignal,passwordSignal,aggainPasswordSignal] //聚合信号，每个信号值改变时都会监听的到
                       reduce:^id(NSNumber *aNumber, //reduce解包，把signal解包成对应的nsnumber类型，因为上面的signal通过map映射转成了number信号
                                  NSNumber *pNumber,
                                  NSNumber *agNumber){
        return @([aNumber boolValue] && [pNumber boolValue] && [agNumber boolValue]);
    }]map:^id(id value) { //map映射成color信号
        @strongify(self)
        self.loginButton.enabled = [value boolValue];
        return [value boolValue] ? [UIColor blueColor] : [UIColor greenColor];
    }]subscribeNext:^(UIColor *color) { //订阅信号
        @strongify(self)
        self.loginButton.backgroundColor = color;
    }];
    
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"------%@",[NSThread currentThread]);
    }];
}

- (RACSignal *)textFiledSignal:(UITextField *)textFiled { //利用map映射把原本textFiled的信号是string 转换成number
    return [textFiled.rac_textSignal map:^id(NSString *value) {
        return @(value.length > 2);
    }];
    
    
    
}

#pragma mark - Rac测试
- (void)test {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) { //创建信号
        [subscriber sendNext:self.tableView]; //发送信号
        return [RACDisposable disposableWithBlock:^{
            //当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
        }];
    }];
    
    [signal subscribeNext:^(id x) { //订阅信号
        UITableView *table = (UITableView *)x;
        //NSLog(@"%@",table);
    }error:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    
    RACSubject *subject = [RACSubject subject];//Racsignal的子类 需要先订阅，再发送信号，可用于代替代理，block
    [subject subscribeNext:^(id x) { //订阅信号
        if ([x isKindOfClass:[NSString class]]) {
            //NSLog(@"%@",x);
        }else {
            //NSLog(@"%@",x);
        }
    }];
    
    [subject sendNext:@"111"]; //发送信号
    [subject sendNext:self.tableView];
    
    
    //手势点击监听
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        
    }];
    
    
    //遍历数组
    NSArray *numbers = @[@"1",@"2",@"3",@"4"];
    [[numbers.rac_sequence.signal filter:^BOOL(NSString *value) {
        return ![value isEqualToString:@"2"];
    }]subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //遍历字典
    NSDictionary *dict = @{@"你":@"ABC",@"我":@(22),@"他":@"1",@"一":@"2"};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        //RACTupleUnpack(NSString *key,NSString *value) = x;
        //NSLog(@"%@ %@", key, value);
    }];
    
    
    //监听某个属性值相当于kvo
    [RACObserve(self, strting)subscribeNext:^(id x) {
        //NSLog(@"new value is %@", x);
    }];
    self.strting = @"11";
    
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, SCREENWIDTH, 100)];
    [self.view addSubview:textFiled];
    //    [[[textFiled.rac_textSignal filter:^BOOL(NSString *value) {
    //        self.rightButton.backgroundColor =  value.length > 10 ? [UIColor blueColor] : [UIColor yellowColor];
    //        return value.length > 10;
    //    }]map:^id(NSString *value) {
    //        return @(value.length);
    //    }]subscribeNext:^(id x) {
    //        NSLog(@"new value is %@", x);
    //    }];
    
    
    
    RAC(self.rightButton,backgroundColor) = [[textFiled.rac_textSignal map:^id(NSString *value) {
        NSLog(@"new value is %@", value);
        return @(value.length > 2);
        
    }]map:^id(NSNumber *value) {
        NSLog(@"is %@", value);
        return [value boolValue] ? [UIColor blueColor] : [UIColor yellowColor];
    }];
    
    //间隔两秒信号被订阅
    [[self.amountTextFiled.rac_textSignal throttle:2]subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //donext附加操作
    [[[self.amountTextFiled.rac_textSignal doNext:^(id x) {
        self.amountTextFiled.backgroundColor = [UIColor redColor];
    }]throttle:0.5]subscribeNext:^(id x) {
        self.amountTextFiled.backgroundColor = [UIColor clearColor];
        NSLog(@"%@",x);
    }];
    
    //定时器
    [[[RACSignal interval:2
              onScheduler:[RACScheduler mainThreadScheduler]]
      takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
