//
//  ObjcConverter.m
//  OpenCC
//
//  Created by 邓翔 on 2017/3/9.
//
//

#import "ObjcConverter.h"
#import "Converter.hpp"
#import "Config.hpp"

@interface ObjcConverter() {
    @private opencc::ConverterPtr converter;
}

@end

@implementation ObjcConverter

- (instancetype _Nullable)initWithConfig:(NSString * _Nonnull)jsonConfig error:(NSError * _Nullable __autoreleasing * _Nonnull)error {
    if (self = [super init]) {
        opencc::Config conf;
        NSString *configDir = [[NSBundle bundleForClass:[self class]] resourcePath];
        try {
            converter = conf.NewFromString([jsonConfig UTF8String], [configDir UTF8String]);
        } catch (opencc::FileNotFound& ex) {
            if (error) {
                NSString *description = [NSString stringWithCString:ex.what() encoding:NSUTF8StringEncoding];
                NSDictionary *errorInfo = @{NSLocalizedDescriptionKey : description};
                *error = [NSError errorWithDomain:OpenCCErrorDomain code:OpenCCErrorCodeFileNotFound userInfo:errorInfo];
            }
            return nil;
        } catch (opencc::InvalidFormat& ex) {
            if (error) {
                NSString *description = [NSString stringWithCString:ex.what() encoding:NSUTF8StringEncoding];
                NSDictionary *errorInfo = @{NSLocalizedDescriptionKey : description};
                *error = [NSError errorWithDomain:OpenCCErrorDomain code:OpenCCErrorCodeInvalidFormat userInfo:errorInfo];
            }
            return nil;
        } catch (opencc::InvalidTextDictionary& ex) {
            if (error) {
                NSString *description = [NSString stringWithCString:ex.what() encoding:NSUTF8StringEncoding];
                NSDictionary *errorInfo = @{NSLocalizedDescriptionKey : description};
                *error = [NSError errorWithDomain:OpenCCErrorDomain code:OpenCCErrorCodeInvalidTextDictionary userInfo:errorInfo];
            }
            return nil;
        } catch (...) {
            if (error) {
                NSString *description = @"unknown error";
                NSDictionary *errorInfo = @{NSLocalizedDescriptionKey : description};
                *error = [NSError errorWithDomain:OpenCCErrorDomain code:OpenCCErrorCodeUnknown userInfo:errorInfo];
            }
            return nil;
        }
    }
    return self;
}

- (NSString * _Nullable)convert:(NSString * _Nonnull)text error:(NSError * _Nullable __autoreleasing * _Nonnull)error {
    try {
        std::string string = converter->Convert([text UTF8String]);
        return [NSString stringWithCString:string.c_str() encoding:NSUTF8StringEncoding];
    } catch (opencc::Exception& ex) {
        if (error) {
            NSString *description = [NSString stringWithCString:ex.what() encoding:NSUTF8StringEncoding];
            NSDictionary *errorInfo = @{NSLocalizedDescriptionKey : description};
            *error = [NSError errorWithDomain:OpenCCErrorDomain code:OpenCCErrorCodeUnknown userInfo:errorInfo];
        }
        return nil;
    }
}

- (void)dealloc {
    converter.reset();
}

@end

NSString *OpenCCErrorDomain = @"ddddxxx.OpenCC";
