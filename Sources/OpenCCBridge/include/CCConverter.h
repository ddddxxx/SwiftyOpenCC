//
//  CCConverter.h
//  OpenCC
//
//  Created by ddddxxx on 2018/5/5.
//

#import <Foundation/Foundation.h>

#import "CCDict.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCConverter : NSObject

- (instancetype)initWithName:(NSString *)name
                segmentation:(CCDict *)segmentation
             conversionChain:(NSArray<CCDict *> *)chain;

- (NSString * _Nullable)convert:(NSString *)text error:(NSError * _Nullable __autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
