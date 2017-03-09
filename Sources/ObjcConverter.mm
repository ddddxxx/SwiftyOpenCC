//
//  ObjcConverter.m
//  OpenCC
//
//  Created by 邓翔 on 2017/3/9.
//
//

#define OPENCC_EXPORT

#import "ObjcConverter.h"

#import <string>
#import "SimpleConverter.hpp"

@interface ObjcConverter() {
    @private opencc::SimpleConverter *converter;
}

@end

@implementation ObjcConverter

- (instancetype)initWithConfig:(NSString *)file {
    if (self = [super init]) {
        const std::string *c = new std::string([file UTF8String]);
        converter = new opencc::SimpleConverter(*c);
    }
    return self;
}

- (NSString *)convert:(NSString *)text {
    std::string string = converter->Convert([text UTF8String]);
    return [NSString stringWithCString:string.c_str() encoding:NSUTF8StringEncoding];
}

@end
