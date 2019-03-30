//
//  CCConverter.m
//  OpenCC
//
//  Created by ddddxxx on 2018/5/5.
//

#import "CCConverter.h"
#import "CCDict-Private.h"
#import "CCError.h"

#import "Converter.hpp"
#import "MaxMatchSegmentation.hpp"
#import "Conversion.hpp"
#import "ConversionChain.hpp"

@interface CCConverter() {
@private
    opencc::ConverterPtr _converter;
    CCDict *_segmentation;
    NSArray<CCDict *> *_chain;
}
@end

@implementation CCConverter

- (instancetype)initWithName:(NSString *)name
                segmentation:(CCDict *)segmentation
             conversionChain:(NSArray<CCDict *> *)chain {
    if (self = [super init]) {
        _segmentation = segmentation;
        _chain = chain;
        std::list<opencc::ConversionPtr> conversions;
        for (CCDict *cov in chain) {
            auto conversion = opencc::ConversionPtr(new opencc::Conversion(cov.dict));
            conversions.push_back(conversion);
        }
        auto covName = std::string(name.UTF8String);
        auto covSeg = opencc::SegmentationPtr(new opencc::MaxMatchSegmentation(segmentation.dict));
        auto covChain = opencc::ConversionChainPtr(new opencc::ConversionChain(conversions));
        _converter = opencc::ConverterPtr(new opencc::Converter(covName, covSeg, covChain));
    }
    return self;
}

- (NSString *)convert:(NSString *)text error:(NSError **)error {
    try {
        std::string string = _converter->Convert(text.UTF8String);
        return [NSString stringWithCString:string.c_str() encoding:NSUTF8StringEncoding];
    } catch (opencc::Exception& ex) {
        if (error) {
            NSString *description = [NSString stringWithCString:ex.what() encoding:NSUTF8StringEncoding];
            NSDictionary *errorInfo = @{NSLocalizedDescriptionKey : description};
            *error = [NSError errorWithDomain:kOpenCCErrorDomain code:OpenCCErrorCodeUnknown userInfo:errorInfo];
        }
        return nil;
    }
}

- (void)dealloc {
    _converter.reset();
}

@end
