//
//  StringUtils.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SCCompressMode) {
    SCCompressModeNone = 0,     //无压缩模式
    SCCompressModeWidthFit,     //给定宽度，等比例压缩
    SCCompressModeHeightFit,    //给定高度，等比例压缩
    SCCompressModeFill          //给定高度和宽度，按尺寸压缩
};

@interface StringUtils : NSString
/**
 * 判断是否为纯数字：
 */
+ (BOOL)isOnlyNumber:(NSString *)string;

/**
 * 是否为手机号码
 */
+(BOOL) isValidateMobile:(NSString *)mobile;

/**
 * 是否为固话号码
 */
+(BOOL) isValidateFixedPhone:(NSString *)phone;

/**
 str的正则表达式验证
 @param     str     验证的字符串
 @param     regex   正则表达式
 @return    BOOL    是否满足
 */
+ (BOOL)isVaildsStr:(NSString *)str forRegex:(NSString *)regex;

/**
 * 隐藏手机号中间4位
 */
+ (NSString *)numberSuitScanf:(NSString*)number;

/**
 * 是否为手机号/固话号码
 */
+ (BOOL)validateContactNumber:(NSString *)mobileNum;

/**
 md5加密
 @param     input       原字符串
 @return    NSString    md5加密后字符串
 */
+ (NSString *)md5HexDigest:(NSString*)input;

/**
 动态保留小数点后位数
 
 @param price 数值
 @param position 位数
 @return 字符串
 */
+ (NSString *)notRounding:(id)price
               afterPoint:(NSInteger)position;

/**
 时间戳(秒)转time(hh:mm:ss)

 @param timeStamp 时间
 @param seperator 格式
 */
+ (NSString *)timeStrWithTimestamp:(long)timeStamp seperator:(NSString *)seperator;

/**
 字符串替换

 @param filterStr 需要查找的字符串
 @param superString 原始字符串
 @return 字符串
 */
+ (NSString *)filterString:(NSString *)filterStr fromString:(NSString *)superString;


//获取资源的绝对路径
+ (NSString *)resoureUrlStrWithPath:(NSString *)pathStr
                            baseUrl:(NSString *)baseUrl;

+ (NSString *)resoureUrlStrWithPath:(NSString *)pathStr
                            baseUrl:(NSString *)baseUrl
                       compressMode:(SCCompressMode)compressMode
                         targetSize:(CGSize)targetSize;

+ (NSString *)resoureUrlStrWithPath:(NSString *)pathStr
                             params:(NSDictionary *)params
                            baseUrl:(NSString *)baseUrl;

/**
 从view到其所有的父视图，全部退出编辑

 @param subView 父视图
 */
+ (void)endEditedFromView:(UIView *)subView;

/**
 计算textView高度
 
 @param str 字符串
 @param font 字体大小
 @param width 显示宽度
 @return 高度
 */
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;

/**
 读取本地JSON文件

 @param name 文件名
 @return json数据
 */
+ (NSDictionary *)readLocalFileWithName:(NSString *)name;


/**
 TextField的Placehoder颜色设置(适配iOS13)

 @param placehoder 提示文字
 @param color 颜色
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)setTextFieldPlacehoder:(NSString *)placehoder Color:(UIColor *)color;
@end
