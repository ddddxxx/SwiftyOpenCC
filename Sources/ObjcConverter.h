//
//  ObjcConverter.h
//  OpenCC
//
//  Created by 邓翔 on 2017/3/9.
//
//

#import <Foundation/Foundation.h>

@interface ObjcConverter : NSObject

- (instancetype)initWithConfig:(NSString *)file;

- (NSString *)convert:(NSString *)text;

@end
