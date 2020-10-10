//
//  NSString+BDModel.m
//

#import "NSString+BDModel.h"

@implementation NSString (BDModel)

- (NSString *)zm_underlineFromCamel {
    return self; // 该项目不需要转
    
//    if (self.length == 0) {
//        return self;
//    }
//    
//    BOOL isPrevCharCaseAppendUnderLine = NO;
//    NSMutableString *string = [NSMutableString string];
//    for (NSUInteger i = 0; i < self.length - 1; i++) {
//        unichar c = [self characterAtIndex:i];
//        NSString *cString = [NSString stringWithFormat:@"%c", c];
//        NSString *cStringLower = [cString lowercaseString];
//        
//        unichar cNext = [self characterAtIndex:i + 1];
//        NSString *cNextString = [NSString stringWithFormat:@"%c", cNext];
//        NSString *cNextStringLower = [cNextString lowercaseString];
//        
//        [string appendString:cStringLower];
//        
//        BOOL isCaseChanged = NO;
//        if ([cString isEqualToString:cStringLower] &&
//            ![cNextString isEqualToString:cNextStringLower]) {
//            isCaseChanged = YES;
//        }
//        else if (![cString isEqualToString:cStringLower] &&
//                 [cNextString isEqualToString:cNextStringLower]) {
//            isCaseChanged = YES;
//        }
//        
//        if (!isPrevCharCaseAppendUnderLine) {
//            isPrevCharCaseAppendUnderLine = NO;
//            if (isCaseChanged) {
//                if (![cString isEqualToString:@"_"] &&
//                    ![cNextString isEqualToString:@"_"]) {
//                    [string appendString:@"_"];
//                    isPrevCharCaseAppendUnderLine = YES;
//                }
//            }
//        }
//        else {
//            isPrevCharCaseAppendUnderLine = NO;
//        }
//        
//        if (i == self.length - 2) {
//            [string appendString:cNextStringLower];
//        }
//    }
//    
//    return string;
}

- (NSString *)zm_camelFromUnderline {
    return self; // 该项目不需要转
    
//    if (self.length == 0) {
//        return self;
//    }
//    
//    NSMutableString *string = [NSMutableString string];
//    NSArray *cmps = [self componentsSeparatedByString:@"_"];
//    for (NSUInteger i = 0; i < cmps.count; i++) {
//        NSString *cmp = cmps[i];
//        if (i && cmp.length) {
//            [string appendString:[NSString stringWithFormat:@"%c", [cmp characterAtIndex:0]].uppercaseString];
//            if (cmp.length >= 2) {
//                [string appendString:[cmp substringFromIndex:1]];
//            }
//        }
//        else {
//            [string appendString:cmp];
//        }
//    }
//    
//    return string;
}

- (NSString *)zm_firstCharLower {
    if (self.length == 0) {
        return self;
    }
    
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].lowercaseString];
    if (self.length >= 2) {
        [string appendString:[self substringFromIndex:1]];
    }
    
    return string;
}

- (NSString *)zm_firstCharUpper {
    if (self.length == 0) {
        return self;
    }
    
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].uppercaseString];
    if (self.length >= 2) {
        [string appendString:[self substringFromIndex:1]];
    }
    
    return string;
}

- (BOOL)zm_isPureInt {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)zm_urlString {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    NSString *urlStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                             NULL,
                                                                                             kCFStringEncodingUTF8));
    return urlStr;
#pragma clang diagnostic pop
}

- (NSURL *)zm_url {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [NSURL URLWithString:[self zm_urlString]];
#pragma clang diagnostic pop
}

@end
