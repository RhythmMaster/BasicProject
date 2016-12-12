//
//  HZProfessionViewModel.m
//  dddd
//
//  Created by tang on 16/11/23.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZProfessionViewModel.h"

@implementation HZProfessionViewModel

- (void)getProfessionWithCompletionHandler:(void (^)(NSError * error))completionHandler {
    [HZProfessionNetManager getMedicPostCompletionHandler:^(id model, NSError *error) {
        if (!error) {
            self.yijiModel = model;
        }
        !completionHandler ?: completionHandler(error);
    }];
   
}

- (void)getSelectedWithID:(NSString *)ID completionHandler:(void (^)(NSError *))completionHandler {
    [HZProfessionNetManager getSelectMedicPostWithID:ID completionHandler:^(id model, NSError *error) {
        if (!error) {
            self.selectedModel = model;
        }
        !completionHandler ?: completionHandler(error);
    }];
}

- (NSString *)getIDWithIndex:(NSInteger)index {
    return [[[self.yijiModel objectForKey:@"CONTENT"] objectAtIndex:index] objectForKey:@"id"];
}

- (NSInteger)number {
    return ((NSArray *)[self.selectedModel objectForKey:@"CONTENT"]).count;
}
- (NSString *)getSelectedIDWithIndex:(NSInteger)index {
    return [[[self.selectedModel objectForKey:@"CONTENT"] objectAtIndex:index] objectForKey:@"id"];
}
- (NSString *)getSelectNameWithIndex:(NSInteger)index {
    return [[[self.selectedModel objectForKey:@"CONTENT"] objectAtIndex:index] objectForKey:@"name"];
}







@end
