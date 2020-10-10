//
//  BDModel.h
//  iOSApp
//

#import <Foundation/Foundation.h>

#import "NSObject+BDModel.h"

@class BDModel;

typedef void (^BDModelFetchSingleMoreDataSuccess)(__kindof BDModel *result, BOOL hasMore);
typedef void (^BDModelFetchSingleDataSuccess)(__kindof BDModel *result);
typedef void (^BDModelFetchArrayDataSuccess)(NSArray<__kindof BDModel *> *result, BOOL hasMore);
typedef void (^BDModelFetchNoMoreArrayDataSuccess)(NSArray<__kindof BDModel *> *result);
typedef void (^BDModelFetchDataFailure)(NSError *error);

@interface BDModel : NSObject <BDModelProtocol>

#warning if you want to transform json to object and remember the last time key value data,you must set the key no "__"

/** 对象-> json -> 对象，如果需要记录其他的字段的值，不能将这些字段设置为“__”,因为这将导致该字段不会去转换 */


@property (nonatomic, copy) NSString *theDescription;

@property (nonatomic, assign) int intResult;

+ (void)fetchArrayDataWithParams:(NSDictionary *)params
                      scrollView:(UIScrollView *)scrollView
                         success:(BDModelFetchArrayDataSuccess)success
                         failure:(BDModelFetchDataFailure)failure;

- (instancetype)jsonCopy;

@end
