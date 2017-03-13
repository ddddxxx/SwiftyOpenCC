//
//  ObjcConverter.h
//  OpenCC
//
//  Created by 邓翔 on 2017/3/9.
//
//

#import <Foundation/Foundation.h>

@interface ObjcConverter : NSObject

- (instancetype _Nullable)initWithConfig:(NSString * _Nonnull)jsonConfig error:(NSError * _Nullable __autoreleasing * _Nonnull)error;

- (NSString * _Nullable)convert:(NSString * _Nonnull)text error:(NSError * _Nullable __autoreleasing * _Nonnull)error;

@end

FOUNDATION_EXPORT NSString * _Nonnull OpenCCErrorDomain;

typedef enum : NSUInteger {
    OpenCCErrorCodeFileNotFound,
    OpenCCErrorCodeInvalidFormat,
    OpenCCErrorCodeInvalidTextDictionary,
    OpenCCErrorCodeUnknown,
} OpenCCErrorCode;
