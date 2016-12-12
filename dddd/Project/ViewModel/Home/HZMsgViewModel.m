//
//  HZMsgViewModel.m
//  dddd
//
//  Created by NSX443 on 16/11/21.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMsgViewModel.h"

@implementation HZMsgViewModel

- (NSMutableArray<HZMsgContentModel *> *)msgConent {
    if (!_msgConent) {
        _msgConent = [NSMutableArray new];
    }
    return _msgConent;
}
- (HZMsgModel *)msgModel {
    if (!_msgModel) {
        _msgModel = [HZMsgModel new];
    }
    return _msgModel;
}

- (void)getMsgWithRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler {
    NSInteger tmpPage = 1;
    if (requestMode == VMRequestModeMore) {
        tmpPage = _page + 1;
    }
    [HZMsgNetManager getMsgWithPage:[NSString stringWithFormat:@"%ld", tmpPage] rows:@"15" completionHandler:^(HZMsgModel *model, NSError *error) {
        if (!error) {
            if (requestMode == VMRequestModeRefresh) {
                [self.msgConent removeAllObjects];
            }
            self.msgModel = model;
            [self.msgConent addObjectsFromArray:model.content];
            _page = tmpPage;
            
        }
        !completionHandler ?: completionHandler(error);
    }];
}

- (NSInteger)rowNumber {
    return self.msgConent.count;
}
- (HZMsgContentModel *)getMsgContentModelForRow:(NSInteger)row {
    return self.msgConent[row];
}
- (NSString *)getMsgTypeForRow:(NSInteger)row {
    return [self getMsgContentModelForRow:row].msgType;
}
- (NSString *)getMsgTypeNameForRow:(NSInteger)row {
    return [self getMsgContentModelForRow:row].msgTypeName;
}
- (NSString *)getMsgContentForRow:(NSInteger)row {
    return [self getMsgContentModelForRow:row].msgContent;
}
- (NSString *)getCreateTimeForRow:(NSInteger)row {
    return [self getMsgContentModelForRow:row].createTime;
}
- (BOOL)getIsReadForRow:(NSInteger)row {
    return [self getMsgContentModelForRow:row].isRead;
}


















@end
