//
//  NWForm.h
//  SandBox112
//
//  Created by Jeff Chau on 17/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NWForm : NSObject {
    UIViewController *caller;
    void (^_completionHandler)(NSNumber * refNum);
    void (^_progressHandler)(float precent);
    NSString *serverAddr;
}

@property (nonatomic, retain) NSString *serverAddr;

- (void)postForm:(NSDictionary *)params image:(NSDictionary *) inImage completion:(void(^)(NSNumber *))handler progress:(void(^)(float)) progressHandler;
- (bool)isNetworkOK;

@end
