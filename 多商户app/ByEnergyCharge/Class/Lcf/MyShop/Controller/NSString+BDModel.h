//
//  NSString+BDModel.h
//

#import <Foundation/Foundation.h>

@interface NSString (BDModel)

/**
 *  驼峰转下划线（loveYou -> love_you）
 */
- (NSString *)zm_underlineFromCamel;
/**
 *  下划线转驼峰（love_you -> loveYou）
 */
- (NSString *)zm_camelFromUnderline;
/**
 * 首字母变大写
 */
- (NSString *)zm_firstCharUpper;
/**
 * 首字母变小写
 */
- (NSString *)zm_firstCharLower;

- (BOOL)zm_isPureInt;

- (NSString *)zm_urlString;

- (NSURL *)zm_url;

@end
