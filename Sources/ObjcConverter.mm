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

- (instancetype)initWithConfig:(NSString *)jsonConfig {
    if (self = [super init]) {
        opencc::Config conf;
        NSString *configDir = [[NSBundle bundleForClass:[self class]] resourcePath];
        converter = conf.NewFromString([jsonConfig UTF8String], [configDir UTF8String]);
    }
    return self;
}

- (NSString *)convert:(NSString *)text {
    std::string string = converter->Convert([text UTF8String]);
    return [NSString stringWithCString:string.c_str() encoding:NSUTF8StringEncoding];
}

@end
