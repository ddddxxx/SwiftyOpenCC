//
//  CCDict.m
//  OpenCC
//
//  Created by ddddxxx on 2018/5/5.
//

#import "CCDict-Private.h"
#import "CCError.h"

#import "DartsDict.hpp"
#import "DictGroup.hpp"

@interface CCDict() {
@private opencc::DictPtr _dict;
}
@end

@implementation CCDict

- (opencc::DictPtr)dict {
    return _dict;
}

- (instancetype)initWithURL:(NSURL *)url error:(NSError * _Nullable *)error {
    if (self = [super init]) {
        std::string path = std::string(url.path.UTF8String);
        *error = catchOpenCCException(^{
            self->_dict = opencc::SerializableDict::NewFromFile<opencc::DartsDict>(path);
        });
        if (*error) {
            return nil;
        }
    }
    return self;
}

- (instancetype)initWithDicts:(NSArray<CCDict *> *)dicts {
    if (self = [super init]) {
        std::list<opencc::DictPtr> list;
        for (CCDict *dict in dicts) {
            list.push_back(dict.dict);
        }
        _dict = opencc::DictGroupPtr(new opencc::DictGroup(list));
    }
    return self;
}

- (void)dealloc {
    _dict.reset();
}

@end
