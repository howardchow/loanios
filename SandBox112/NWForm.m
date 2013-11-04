//
//  NWForm.m
//  SandBox112
//
//  Created by Jeff Chau on 17/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWForm.h"
#import "AFHTTPRequestOperationManager.h"
#import "Reachability.h"

//#define URL @"10.42.16.38:8080/guestbook/apply/saveFromWS"
#define URL @"secure-escarpment-4348.herokuapp.com/apply/saveFromWS"

@implementation NWForm

@synthesize serverAddr;

- (id) init {
    self = [super init];
    if (self) {
        serverAddr = URL;
    }
    return self;
}

- (bool)isNetworkOK {

    Reachability *networkReachability = [Reachability reachabilityWithHostName:@"google.com"];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return false;
    } else {
        return true;
    }
    
}

- (void)postForm:(NSDictionary *)params image:(NSDictionary *) inImage completion:(void(^)(NSNumber *))handler progress:(void(^)(float)) progressHandler
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    UIImage *image_hkid = (UIImage *) [inImage objectForKey:@"hkid"];
    UIImage *image_nameCard = (UIImage *) [inImage objectForKey:@"nameCard"];
    UIImage *image_salary = (UIImage *) [inImage objectForKey:@"salary"];
    UIImage *image_address = (UIImage *) [inImage objectForKey:@"address"];
    
    NSString *realURL = [@"http://" stringByAppendingString:serverAddr];
    
    AFHTTPRequestOperation *operation = [manager POST:realURL parameters:params
constructingBodyWithBlock: ^(id<AFMultipartFormData> formData) {
        NSData * idImageData = UIImageJPEGRepresentation(image_hkid, 1.0);
        if (idImageData != nil) {
            [formData appendPartWithFileData:idImageData
                                    name:@"IDPhoto"
                                fileName:@"ID_copy.jpg"
                                mimeType:@"image/jpeg"];
        }
        NSData * nameCardImageData = UIImageJPEGRepresentation(image_nameCard, 1.0);
        if (nameCardImageData != nil) {
            [formData appendPartWithFileData:nameCardImageData
                                    name:@"NameCardPhoto"
                                fileName:@"nameCard_copy.jpg"
                                mimeType:@"image/jpeg"];
        }
        NSData * salaryImageData = UIImageJPEGRepresentation(image_salary, 1.0);
        if (salaryImageData != nil) {
            [formData appendPartWithFileData:salaryImageData
                                    name:@"SalaryPhoto"
                                fileName:@"nameSalary_copy.jpg"
                                mimeType:@"image/jpeg"];
        }
        NSData * addressImageData = UIImageJPEGRepresentation(image_address, 1.0);
        if (addressImageData != nil) {
            [formData appendPartWithFileData:addressImageData
                                    name:@"AddressPhoto"
                                fileName:@"nameAddress_copy.jpg"
                                mimeType:@"image/jpeg"];
            }
        }
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSNumber *refNum = [responseObject valueForKey:@"ref"];
        /* call back on successful form submit */
        _completionHandler = [handler copy];
        _completionHandler(refNum);
        _completionHandler = nil;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Network" message: @"Fail to connect server" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
        
        float percentDone = ((float)(totalBytesWritten) / (float)(totalBytesExpectedToWrite));
        NSLog(@"%f : %lld / %lld",percentDone,totalBytesWritten,totalBytesExpectedToWrite);
        
        _progressHandler = [progressHandler copy];
        _progressHandler(percentDone);
        _progressHandler = nil;
        
    }];
    
    
}

@end
