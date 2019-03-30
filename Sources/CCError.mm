//
//  CCError.m
//  OpenCC
//
//  Created by ddddxxx on 2018/5/5.
//

#import "CCError.h"

#import "Exception.hpp"

NSString *kOpenCCErrorDomain = @"ddddxxx.OpenCC";

NSError* openccError(NSString *desc, OpenCCErrorCode code) {
    NSDictionary *errorInfo = @{NSLocalizedDescriptionKey : desc};
    return [NSError errorWithDomain:kOpenCCErrorDomain
                               code:code
                           userInfo:errorInfo];
}

static NSError* convertOpenCCException(opencc::Exception ex, OpenCCErrorCode code) {
    NSString *description = [NSString stringWithCString:ex.what() encoding:NSUTF8StringEncoding];
    return openccError(description, code);
}

NSError* _Nullable catchOpenCCException(void (^block)()) {
    try {
        block();
        return nil;
    } catch (opencc::FileNotFound& ex) {
        return convertOpenCCException(ex, OpenCCErrorCodeFileNotFound);
    } catch (opencc::InvalidFormat& ex) {
        return convertOpenCCException(ex, OpenCCErrorCodeInvalidFormat);
    } catch (opencc::InvalidTextDictionary& ex) {
        return convertOpenCCException(ex, OpenCCErrorCodeInvalidTextDictionary);
    } catch (opencc::InvalidUTF8& ex) {
        return convertOpenCCException(ex, OpenCCErrorCodeInvalidUTF8);
    } catch (opencc::Exception& ex) {
        return convertOpenCCException(ex, OpenCCErrorCodeUnknown);
    }
}
