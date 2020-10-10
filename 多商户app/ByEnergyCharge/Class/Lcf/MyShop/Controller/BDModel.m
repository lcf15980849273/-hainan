//
//  BDModel.m
//  iOSApp
//

#import "BDModel.h"
//#import "BugReportTool.h"

@class BDResultModel;

void reportNoImplementMethod(id self, SEL sel){
    NSString *errorString = [NSString stringWithFormat:@"-[%@ %@]: unrecognized selector no implement method",
                             NSStringFromClass([self class]),
                             NSStringFromSelector(sel)];
    NSException *exception = [NSException exceptionWithName:NSStringFromClass([self class])
                                                     reason:errorString
                                                   userInfo:nil];
//    [BugReportTool reportException:exception];
}

@implementation BDModel

#pragma mark - Public Method

+ (void)fetchArrayDataWithParams:(NSDictionary *)params
                      scrollView:(UIScrollView *)scrollView
                         success:(BDModelFetchArrayDataSuccess)success
                         failure:(BDModelFetchDataFailure)failure {
    
}

- (instancetype)jsonCopy {
    return [[self class] zm_modelFromJson:[self zm_toJson]];
}

#pragma mark - Protocol
#pragma mark <BDModelProtocol>
+ (id)zm_jsonKeyForPropertyName:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"ID"]) {
        return @"id";
    }
    else if ([propertyName isEqualToString:@"theDescription"]) {
        return @"description";
    }
    else if ([propertyName isEqualToString:@"intResult"]) {
        return @"result";
    }
    else if (propertyName.length >= 2 &&
             [propertyName characterAtIndex:0] == '_' &&
             [propertyName characterAtIndex:1] == '_') {
        return [[propertyName substringFromIndex:2] zm_underlineFromCamel];
    }
    return [propertyName zm_underlineFromCamel];
    
    // 子类override
    ///<Model#> *model;
    //if ([propertyName isEqualToString:VDKeyPath(model, <#property#>)]) {
    //  return @"json_key";
    //}
    //
    //return [super zm_jsonKeyForPropertyName:propertyName];
}

+ (BOOL)zm_shouldIgnoredPropertyName:(NSString *)propertyName {
    if (propertyName.length >= 2 &&
        [propertyName characterAtIndex:0] == '_' &&
        [propertyName characterAtIndex:1] == '_') {
        return YES;
    }
    
    return NO;
    
    // 子类override
    ///<Model#> *model;
    //if ([propertyName isEqualToString:VDKeyPath(model, <#property#>)]) {
    //  return YES;
    //}
    //
    //return [super zm_shouldIgnoredPropertyName:propertyName];
}

+ (Class)zm_classForArrayPropertyName:(NSString *)propertyName {
    return nil;
    
    // 子类override
    ///<Model#> *model;
    //if ([propertyName isEqualToString:VDKeyPath(model, <#property#>)]) {
    //  return [<#Model#> class];
    //}
    //
    //return [super zm_classForArrayPropertyName:propertyName];
}

- (void)zm_modelDidTransformFromJson:(NSDictionary *)json {
    
}

- (void)zm_jsonDidTransform:(NSMutableDictionary *)json {
    
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    class_addMethod([self class], sel, (IMP)reportNoImplementMethod, "v@:@");
    
    return [super resolveInstanceMethod:sel];
}

@end
