//
//  ByEnergyUtilsMacro.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/4/24.
//  Copyright © 2020年 newyea. All rights reserved.
//

#ifndef ByEnergyUtilsMacro_h
#define ByEnergyUtilsMacro_h


// 当前顶层Controller
#define ByEnergyTopVC                          ([UIViewController ByEnergy_topVC])

// 简化代码的宏定义
#define SC_RAC_DEALLOC                         [self rac_willDeallocSignal]
#define SC_RAC_MAP(responseObject)             flattenMap:^RACStream *(responseObject)
#define SC_RAC_NEXT(responseObject)            subscribeNext:^(id responseObject)

#define ByEnergyWeakSekf                       @weakify(self)
#define ByEnergyStrongSelf                     @strongify(self)

//获取系统对象
#define ByEnergyApplication                    [UIApplication sharedApplication]
#define ByEnergyAppWindow                      [UIApplication sharedApplication].delegate.window
#define ByEnergyAppDelegate                    [AppDelegate shareAppDelegate]
#define ByEnergyRootViewController             [UIApplication sharedApplication].delegate.window.rootViewController
#define ByEnergyNotificationCenter             [NSNotificationCenter defaultCenter]

//拼接字符串
#define NSStringFormat(format,...)             [NSString stringWithFormat:format,##__VA_ARGS__]

//字符串判空
#define byEnergyIsNilOrNull(_ref)              (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isKindOfClass:[NSNull class]]) )
#define byEnergyIsValidStr(_ref)               ((byEnergyIsNilOrNull(_ref) == NO) && ([(_ref) isKindOfClass:[NSString class]]) && ([_ref length] > 0))
#define byEnergyClearNilStr(str)               (byEnergyIsValidStr(str)?str:@"")
#define byEnergyClearNiltoZeroStr(str)         (byEnergyIsValidStr(str)?str:@"0")
#define byEnergyClearNilReturnNull(str)        (byEnergyIsValidStr(str)?str:[NSNull null])
#define byEnergyClearNilReturnStr(str,valid)   (byEnergyIsValidStr(str)?str:valid)

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];

//字体
#define ByEnergyBoldFont(FONTSIZE)             [UIFont boldSystemFontOfSize:FONTSIZE]
#define ByEnergyRegularFont(FONTSIZE)                   [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)                   [UIFont fontWithName:(NAME) size:(FONTSIZE)]

//颜色
#define RGB(r, g, b)                           [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define Color(variable)                        [UIColor colorByEnergyWithBinaryString:variable];
#define BackGroundColor                        BYENERGYCOLOR(0xf8f8f8);
#define APPTableSEPRATE                        BYENERGYCOLOR(0xEDEEEE) // 用于App分割线等
#define APPGrayColor                           BYENERGYCOLOR(0xF6F6F6)
#define kNavigationBarBGColor                  BYENERGYCOLOR(0x30313a)
#define kNavigationBarSubBGColor               BYENERGYCOLOR(0x30313a)
#define BYENERGYCOLOR(hex)                     [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0                                                        blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

//定义UIImage对象
#define IMAGEWITHNAME(name)                    [UIImage imageNamed:name]
#define ImageWithFile(_pointer)                [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx",                                                  _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]


//数据验证
#define StrValid(f)                            (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f)                             (StrValid(f) ? f:@"")
#define HasString(str,key)                     ([str rangeOfString:key].location!=NSNotFound)
#define ValidStr(f)                            StrValid(f)
#define ValidDict(f)                           (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f)                          (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f)                            (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls)                      (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f)                           (f!=nil && [f isKindOfClass:[NSData class]])

//头部宏
#define NomalNavBarHeight                      44.0
#define IsIphoneXLater                         (((int)((SCREENHEIGHT/SCREENWIDTH) *100) == 216) ? YES : NO)
#define SafeStatusBarHeight                    (SCREENHEIGHT >= 812.0 ? 24 : 0)
#define SCREENWIDTH                            [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT                           [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS                          [UIScreen mainScreen].bounds
#define IsIphone5                              (SCREENWIDTH == 320 ? YES : NO)

//底部宏
#define SafeAreaBottomHeight                   (kStatusBarHeight > 20.0 ? 34 : 0)
#define NavigationStatusBarHeight              (IsIphoneXLater ? 88.f : 64.f)
#define kStatusBarHeight                       [[UIApplication sharedApplication] statusBarFrame].size.height
#define kTabBarHeight                          ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)
#define kTopHeight                             (kStatusBarHeight + NomalNavBarHeight)
#define StatusBarHeight                        (IsIphoneXLater ? 44.f : 20.f)
#define TabbarHeight                           (IsIphoneXLater ? (49.f + 34.f) : 49.f)

//获取一段时间间隔
#define kStartTime                             CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime                               NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

//打印当前方法名
#define ITTDPRINTMETHODNAME()                  ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

//强弱引用
#define kWeakSelf(type)                        __weak typeof(type) weak##type = type;
#define kStrongSelf(type)                      __strong typeof(type) type = weak##type;

//存储NSUserDefaults
#define USER_DEFAULT                           [NSUserDefaults standardUserDefaults]

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}


#if !ScreenBounds
#define ScreenBounds \
([UIScreen mainScreen].bounds)
#endif

//懒加载类
#define LCFLazyload(className,variable)\
- (className *)variable \
{  \
    if (!_##variable)  \
    {  \
_##variable = [[NSClassFromString(NSStringFromClass([className class])) alloc] init];  \
    }  \
    return _##variable;    \
}

//runtim快速归解档
#define kEncodeRuntime(className)\
- (void)encodeWithCoder:(NSCoder *)encoder\
{\
    unsigned int count;\
    Ivar *ivar = class_copyIvarList([NSClassFromString(NSStringFromClass([className class])) class], &count); \
    for (NSInteger index = 0; index <count; index++) { \
        Ivar iv = ivar[index];\
        const char *name = ivar_getName(iv);\
        NSString *strName = [NSString stringWithUTF8String:name];\
        id value = [self valueForKey:strName];\
        [encoder encodeObject:value forKey:strName];\
    }\
    free(ivar);\
}\

#define kInitCoderRuntime(className)\
- (id)initWithCoder:(NSCoder *)decoder\
{\
    if (self = [super init]) {\
        unsigned int count = 0;\
        Ivar *ivar = class_copyIvarList([NSClassFromString(NSStringFromClass([className class])) class], &count);\
        for (NSInteger index = 0; index<count; index++) { \
            Ivar iva = ivar[index];\
            const char *name = ivar_getName(iva);\
            NSString *strName = [NSString stringWithUTF8String:name];\
            id value = [decoder decodeObjectForKey:strName];\
            [self setValue:value forKey:strName];\
            free(iva);\
        }\
        free(ivar);\
    }\
    return self;\
}\


#endif /* UtilsHeader_h */
