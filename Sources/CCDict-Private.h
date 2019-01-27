//
//  CCDict-Private.h
//  OpenCC
//
//  Created by 邓翔 on 2018/5/5.
//

#import "CCDict.h"

#import "Dict.hpp"

@interface CCDict()

@property (readonly) opencc::DictPtr dict;

@end
