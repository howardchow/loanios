//
//  AppDelegate.h
//  SandBox112
//
//  Created by Jeff Chau on 15/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableDictionary *dict_input;
    NSMutableDictionary *dict_img;
    NSString *appFile;
    NSString *documentsDirectory;
    NSString *selectedProduct;
}

@property (strong, nonatomic) UIWindow *window;

//shared data
@property (nonatomic,retain) NSMutableDictionary *dict_input;
@property (nonatomic,retain) NSMutableDictionary *dict_img;
@property (nonatomic,retain) NSString *appFile;
@property (nonatomic,retain) NSString *documentsDirectory;
@property (nonatomic,retain) NSString *selectedProduct;

@end
