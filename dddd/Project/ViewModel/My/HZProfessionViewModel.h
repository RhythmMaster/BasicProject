//
//  HZProfessionViewModel.h
//  dddd
//
//  Created by tang on 16/11/23.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZProfessionNetManager.h"

@interface HZProfessionViewModel : NSObject

@property(nonatomic) id yijiModel;
@property(nonatomic) id selectedModel;

@property(nonatomic) NSInteger number;

- (void)getProfessionWithCompletionHandler:(void(^)(NSError *error))completionHandler;
- (void)getSelectedWithID:(NSString *)ID completionHandler:(void(^)(NSError *error))completionHandler;


- (NSString *)getIDWithIndex:(NSInteger)index;
- (NSString *)getSelectedIDWithIndex:(NSInteger)index;
- (NSString *)getSelectNameWithIndex:(NSInteger)index;









@end
