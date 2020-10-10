//
//  NSObject+BDModel.m
//

#import "NSObject+BDModel.h"

@implementation NSObject (BDModel)

#pragma mark - Public Method
+ (NSString *)zm_uniqueJsonKeyForPropertyName:(NSString *)propertyName {
    NSString *jsonKey = propertyName;
    id keyMapper = [self zm_jsonKeyForPropertyName:propertyName];
    if ([keyMapper isKindOfClass:[NSString class]]) {
        jsonKey = (NSString *) keyMapper;
    }
    else if ([keyMapper isKindOfClass:[NSArray class]]) {
        jsonKey = ((NSArray *) keyMapper).firstObject;
    }
    
    return jsonKey;
}

+ (__kindof NSObject *)zm_modelFromJson:(NSDictionary *)json {
    id model = [self yy_modelWithJSON:json];
    return model;
}

+ (NSMutableArray<__kindof NSObject *> *)zm_modelArrayFromJsonArray:(NSArray *)jsonArray {
    NSMutableArray *array = [NSMutableArray new];
    [array addObjectsFromArray:[NSArray yy_modelArrayWithClass:self json:jsonArray]];
    return array;
}

- (NSMutableDictionary *)zm_toJson {
    id json = [self yy_modelToJSONObject];
    return json;
}

- (NSMutableDictionary *)zm_toJsonWithKeyArray:(NSArray<NSString *> *)keyArray {
    NSDictionary *fullJson = [self zm_toJson];
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    for (NSString *key in [keyArray copy]) {
        NSString *jsonKey = key;
        id keyMapper = [[self class] modelCustomPropertyMapper][key];
        if ([keyMapper isKindOfClass:[NSString class]]) {
            jsonKey = (NSString *) keyMapper;
        }
        else if ([keyMapper isKindOfClass:[NSArray class]]) {
            jsonKey = ((NSArray *) keyMapper).firstObject;
        }
        
        if (fullJson[jsonKey]) {
            dictionary[jsonKey] = fullJson[jsonKey];
        }
    }
    
    return dictionary;
}

+ (NSMutableArray<NSDictionary *> *)zm_toJsonArray:(NSArray<__kindof NSObject *> *)modelArray {
    NSMutableArray *array = [modelArray yy_modelToJSONObject];
    return array;
}

+ (NSMutableArray<NSDictionary *> *)zm_toJsonArray:(NSArray<__kindof NSObject *> *)modelArray withKeyArray:(NSArray<NSString *> *)keyArray {
    NSMutableArray *array = [NSMutableArray new];
    for (NSObject *model in [modelArray copy]) {
        [array addObject:[model zm_toJsonWithKeyArray:keyArray]];
    }
    
    return array;
}

#pragma mark - Protocol
#pragma mark <YYModel>
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    YYClassInfo *curClassInfo = [YYClassInfo classInfoWithClass:self];
    while (curClassInfo && curClassInfo.superCls != nil) {
        for (YYClassPropertyInfo *propertyInfo in curClassInfo.propertyInfos.allValues) {
            if (!propertyInfo.name) {
                continue;
            }
            
            NSMutableArray *jsonKeyArray = dictionary[propertyInfo.name] ?: [NSMutableArray new];
            
            if ([self respondsToSelector:@selector(zm_jsonKeyForPropertyName:)]) {
                id key = [self zm_jsonKeyForPropertyName:propertyInfo.name];
                if ([key isKindOfClass:[NSString class]]) {
                    if (![jsonKeyArray containsObject:key]) {
                        [jsonKeyArray addObject:key];
                    }
                }
                else if ([key isKindOfClass:[NSArray class]]) {
                    for (NSString *k in [((NSArray *) key) copy]) {
                        if (![jsonKeyArray containsObject:k]) {
                            [jsonKeyArray addObject:k];
                        }
                    }
                }
            }
            
            NSString *key = [propertyInfo.name zm_underlineFromCamel];
            if (![jsonKeyArray containsObject:key]) {
                [jsonKeyArray addObject:key];
            }
            
            key = propertyInfo.name;
            if (![jsonKeyArray containsObject:key]) {
                [jsonKeyArray addObject:key];
            }
            
            dictionary[propertyInfo.name] = jsonKeyArray;
        }
        curClassInfo = curClassInfo.superClassInfo;
    }
    
    return dictionary;
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    YYClassInfo *curClassInfo = [YYClassInfo classInfoWithClass:self];
    while (curClassInfo && curClassInfo.superCls != nil) {
        for (YYClassPropertyInfo *propertyInfo in curClassInfo.propertyInfos.allValues) {
            if (!propertyInfo.name) {
                continue;
            }
            
            if (![propertyInfo.cls isSubclassOfClass:[NSArray class]]) {
                continue;
            }
            
            if (!dictionary[propertyInfo.name]) {
                if ([self respondsToSelector:@selector(zm_classForArrayPropertyName:)]) {
                    Class clazz = [self zm_classForArrayPropertyName:propertyInfo.name];
                    dictionary[propertyInfo.name] = clazz;
                }
            }
        }
        curClassInfo = curClassInfo.superClassInfo;
    }
    
    return dictionary;
}

+ (NSArray<NSString *> *)modelPropertyBlacklist {
    NSMutableArray *array = [NSMutableArray new];
    
    YYClassInfo *curClassInfo = [YYClassInfo classInfoWithClass:self];
    while (curClassInfo && curClassInfo.superCls != nil) {
        for (YYClassPropertyInfo *propertyInfo in curClassInfo.propertyInfos.allValues) {
            if (!propertyInfo.name) {
                continue;
            }
            
            if ([self respondsToSelector:@selector(zm_shouldIgnoredPropertyName:)]) {
                if ([self zm_shouldIgnoredPropertyName:propertyInfo.name]) {
                    [array addObject:propertyInfo.name];
                }
            }
        }
        curClassInfo = curClassInfo.superClassInfo;
    }
    
    // protocol相关系统property
    [array addObject:@"description"];
    [array addObject:@"debugDescription"];
    [array addObject:@"hash"];
    [array addObject:@"superclass"];
    
    return array;
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([self respondsToSelector:@selector(zm_modelDidTransformFromJson:)]) {
        [self zm_modelDidTransformFromJson:dic];
    }
    
    return YES;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    if ([self respondsToSelector:@selector(zm_jsonDidTransform:)]) {
        [self zm_jsonDidTransform:dic];
    }
    
    return YES;
}

- (NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dic {
    return dic;
}

@end
