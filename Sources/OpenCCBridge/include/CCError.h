//
//  CCError.h
//  OpenCC
//
//  Created by ddddxxx on 2018/5/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *kOpenCCErrorDomain;

typedef NS_ENUM(NSInteger, OpenCCErrorCode) {
    OpenCCErrorCodeFileNotFound,
    OpenCCErrorCodeInvalidFormat,
    OpenCCErrorCodeInvalidTextDictionary,
    OpenCCErrorCodeInvalidUTF8,
    OpenCCErrorCodeUnknown,
};

NSError* _Nullable catchOpenCCException(void (^)());

NS_ASSUME_NONNULL_END
