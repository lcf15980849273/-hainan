//
//  StringUtils.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020年 newyea. All rights reserved.
//


#import <CommonCrypto/CommonDigest.h>

@implementation StringUtils
+ (BOOL)isOnlyNumber:(NSString *)string{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/**
 * 是否为手机号码
 */
+(BOOL) isValidateMobile:(NSString *)mobile
{
    
    NSString *phoneRegex = @"^1(3[0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|8[0-9]|9[89])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
/**
 * 是否为固话号码
 */

+(BOOL) isValidateFixedPhone:(NSString *)phone{
    NSString *phs = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phs];
    return [phoneTest evaluateWithObject:phone];
}

/**
 * 是否为手机号/固话号码
 */
+ (BOOL)validateContactNumber:(NSString *)mobileNum{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,175,176,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|7[56]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)
       || ([regextestPHS evaluateWithObject:mobileNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - str的正则表达式验证
+ (BOOL)isVaildsStr:(NSString *)str forRegex:(NSString *)regex {
    BOOL isValid = NO;
    @try {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        isValid = [predicate evaluateWithObject:str];
    }
    @catch (NSException *exception) {
        NSLog(@"isVaildsStr:%@", [exception description]);
        isValid = NO;
    }
    @finally {
        return isValid;
    }
}

/**
 * 隐藏手机号中间4位
 */
+(NSString *)numberSuitScanf:(NSString*)number {
    if ([StringUtils isValidateMobile:number]) {
        NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return numberString;
    }
    return number;
}

+ (NSString *)md5HexDigest:(NSString*)input {
    if (byEnergyIsValidStr(input)==NO) {
        return @"";
    }
    const char *original_str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

+ (NSString *)filterString:(NSString *)filterStr fromString:(NSString *)superString {
    NSMutableString *newStr = [NSMutableString stringWithString:superString];
    [newStr replaceOccurrencesOfString:filterStr withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, superString.length)];
    return newStr;
}

#pragma mark 获取资源的绝对路径
+ (NSString *)resoureUrlStrWithPath:(NSString *)pathStr
                            baseUrl:(NSString *)baseUrl {
    return [StringUtils resoureUrlStrWithPath:pathStr
                                        params:nil
                                       baseUrl:baseUrl];
}

+ (NSString *)resoureUrlStrWithPath:(NSString *)pathStr
                            baseUrl:(NSString *)baseUrl
                       compressMode:(SCCompressMode)compressMode
                         targetSize:(CGSize)targetSize {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (compressMode!=SCCompressModeNone) {
        float scale = [UIScreen mainScreen].scale;
        float width = targetSize.width * scale;
        float height = targetSize.height *scale;
        if (compressMode==SCCompressModeWidthFit) {
            height = 0;
        }
        else if (compressMode==SCCompressModeHeightFit) {
            width = 0;
        }
        NSString *sizeStr = [NSString stringWithFormat:@"%dx%d",(int)width,(int)height];
        [params setObject:sizeStr forKey:@"fileImgSize"];
    }
    
    return [StringUtils resoureUrlStrWithPath:pathStr
                                        params:params
                                       baseUrl:baseUrl];
}

+ (NSString *)resoureUrlStrWithPath:(NSString *)pathStr
                             params:(NSDictionary *)params
                            baseUrl:(NSString *)baseUrl {
    NSMutableString *urlStr = [NSMutableString stringWithCapacity:100];
    if (byEnergyIsValidStr(pathStr)==NO) {
        if (byEnergyIsValidStr(baseUrl)) {
            [urlStr appendString:baseUrl];
        }
        else {
            return nil;
        }
    }
    else if ([pathStr rangeOfString:@"http:"].length>0 || [pathStr rangeOfString:@"https"].length>0) {
        [urlStr appendString:pathStr];
    }
    else {
        [urlStr appendString:[NSString stringWithFormat:@"%@%@",baseUrl,pathStr]];
    }
    
    for (NSString *key in params.allKeys) {
        if ([urlStr rangeOfString:@"?"].length>0) {
            [urlStr appendString:@"&"];
        }
        else {
            [urlStr appendString:@"?"];
        }
        [urlStr appendFormat:@"%@=%@",[StringUtils encodeURIComponentWithString:[key description]], [StringUtils encodeURIComponentWithString:[params[key] description]]];
    }
    
    return urlStr;
}

+ (NSString *)encodeURIComponentWithString:(NSString *)input {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0 || __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_9
    NSString *charactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    NSString *charactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[charactersGeneralDelimitersToEncode stringByAppendingString:charactersSubDelimitersToEncode]];
    NSString *result = [input stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    return result;
    
#else
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef)input,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
#endif
}

/**
 动态保留小数点后位数
 
 @param price 数值
 @param position 位数
 @return 字符串
 */
+ (NSString *)notRounding:(id)price
               afterPoint:(NSInteger)position {
    //生成format格式
    NSString *format = [NSString stringWithFormat:@"%%.%ldf",(long)position];
    CGFloat value = 0.;
    //string 和 number 兼容
    if ([price respondsToSelector:@selector(doubleValue)]) {
        value = [price doubleValue];
    }
    NSString *number = [NSString stringWithFormat:format,value];
    return number;
}

#pragma mark - 时间戳(秒)转time(hh:mm:ss)
+ (NSString *)timeStrWithTimestamp:(long)timeStamp seperator:(NSString *)seperator {
    if (byEnergyIsValidStr(seperator)==NO) {
        seperator = @":";
    }
    long hour = timeStamp/3600;
    timeStamp %= 3600;
    long minute = timeStamp/60;
    timeStamp %= 60;
    long second = timeStamp;
    
    NSString *timeStr = [NSString stringWithFormat:@"%02ld%@%02ld%@%02ld",hour,seperator,minute,seperator,second];
    return timeStr;
}


//从view到其所有的父视图，全部退出编辑
+ (void)endEditedFromView:(UIView *)subView {
    if (byEnergyIsNilOrNull(subView)) {
        return;
    }
    for (UIView* view = subView; view; view = view.superview) {
        [view endEditing:YES];
    }
}

/**
 计算textView高度
 
 @param str 字符串
 @param font 字体大小
 @param width 显示宽度
 @return 高度
 */
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    if (!byEnergyIsValidStr(str)) {
        return 0;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    //, NSKernAttributeName:@1.5f
    NSDictionary *dic = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle };
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    return  ceilf(size.height);
}

// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

/**
 TextField的Placehoder颜色设置(适配iOS13)
 
 @param placehoder 提示文字
 @param color 颜色
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)setTextFieldPlacehoder:(NSString *)placehoder Color:(UIColor *)color{
    if (placehoder.length == 0) {
        return [[NSMutableAttributedString alloc] init];
    }
    NSMutableAttributedString * attributed= [[NSMutableAttributedString alloc]initWithString:placehoder];
    [attributed setAttributes:@{NSForegroundColorAttributeName :color} range:NSMakeRange(0, placehoder.length)];
    return attributed;
}
@end
