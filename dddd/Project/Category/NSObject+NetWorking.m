//
//  NSObject+NetWorking.m
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "NSObject+NetWorking.h"

@implementation NSObject (NetWorking)

+ (id)GET:(NSString *)path parameters:(NSDictionary *)parameters downloadProgress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionHandler{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:kBasePath.tzl_URL];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"application/json", @"text/javascript", nil];
    return [manager GET:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //打印请求的路径，用于调试  上架时，一定要删了，防止别人偷链接地址
        
        !completionHandler ?: completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //打印请求的路径，用于调试  上架时，一定要删了，防止别人偷链接地址
        
        if (error) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kAppdelegate.window animated:YES];
            hud.label.text = @"当前没有网络!";
            //提示框风格
            hud.mode = MBProgressHUDModeText;
            //提示1.5秒钟
            //[hud hide:YES afterDelay:1.5];
            [hud hideAnimated:YES afterDelay:1.5];
        }
        !completionHandler ?: completionHandler(nil, error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters downloadProgress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /**
     经测试,如果使用如下的写法拼接会导致地址缺失,post请求不成功
     AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:kBasePath.tzl_URL];
     
     */
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"application/json", @"text/javascript", nil];
    return [manager POST:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", task.originalRequest);
        !completionHandler ?: completionHandler(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kAppdelegate.window animated:YES];
            
            hud.label.text = @"当前没有网络!";
            //提示框风格
            hud.mode = MBProgressHUDModeText;
            //提示1.5秒钟
            //[hud hide:YES afterDelay:1.5];
            [hud hideAnimated:YES afterDelay:1.5];
        }
        NSLog(@"%@", task.originalRequest);
        !completionHandler ?: completionHandler(nil, error);
    }];
    
}



@end
