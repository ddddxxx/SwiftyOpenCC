//
//  CCDict.h
//  OpenCC
//
//  Created by ddddxxx on 2018/5/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCDict : NSObject

- (instancetype _Nullable)initWithURL:(NSURL *)url error:(NSError * _Nullable *)error;

- (instancetype)initWithDicts:(NSArray<CCDict *> *)dicts;

@end

NS_ASSUME_NONNULL_END
