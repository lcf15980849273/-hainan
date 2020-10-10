//
//  NSObject+BDModel.h
//

#import <Foundation/Foundation.h>

#import <YYModel/YYModel.h>
#import "NSString+BDModel.h"

#if !BDModelJsonKey
#define BDModelJsonKey(path) \
([[self class] zm_jsonKeyForPropertyName:VDKeyPath(self, path)])
#endif

#if !BDModelClassJsonKey
#define BDModelClassJsonKey(target, path) \
([self zm_jsonKeyForPropertyName:VDKeyPath(target, path)])
#endif

@protocol BDModelProtocol <NSObject>

@optional
/**
 * property对应的json key
 * 可返回string数组
 * json转model时识别数组中全部key
 * 若返回数组，第一个值为转化为json时的key
 * 默认返回下划线转驼峰与原name
 */
+ (id)zm_jsonKeyForPropertyName:(NSString *)propertyName;

/**
 * 是否忽略property
 * 默认返回NO
 */
+ (BOOL)zm_shouldIgnoredPropertyName:(NSString *)propertyName;

/**
 * 数组property中item的类型
 * 默认返回BDModel，杜绝Model中包含字典Dictionary
 */
+ (Class)zm_classForArrayPropertyName:(NSString *)propertyName;

/**
 * json转model完成
 * override
 *
 * @param json 数据源
 */
- (void)zm_modelDidTransformFromJson:(NSDictionary *)json;

/**
 * model转json完成
 * override
 *
 * @param json 转换后的json，可自行修改json内容
 */
- (void)zm_jsonDidTransform:(NSMutableDictionary *)json;

@end

@interface NSObject (BDModel) <BDModelProtocol, YYModel>


/**< model转json时使用的json key */
+ (NSString *)zm_uniqueJsonKeyForPropertyName:(NSString *)propertyName;

/**< json转model */
+ (__kindof NSObject *)zm_modelFromJson:(NSDictionary *)json;
/**< json数组转model数组 */
+ (NSMutableArray<__kindof NSObject *> *)zm_modelArrayFromJsonArray:(NSArray *)jsonArray;
/**< model转json */
- (NSMutableDictionary *)zm_toJson;
/**< model转json，仅包包含keyArray */
- (NSMutableDictionary *)zm_toJsonWithKeyArray:(NSArray<NSString *> *)keyArray;
/**< model数组转json数组 */
+ (NSMutableArray<NSDictionary *> *)zm_toJsonArray:(NSArray<__kindof NSObject *> *)modelArray;
/**< model数组转json数组，仅包包含keyArray */
+ (NSMutableArray<NSDictionary *> *)zm_toJsonArray:(NSArray<__kindof NSObject *> *)modelArray withKeyArray:(NSArray<NSString *> *)keyArray;

@end
