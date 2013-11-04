//
//  UIProductViewController.h
//  SandBox112
//
//  Created by Jeff Chau on 22/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UIProductViewController : UITableViewController<UITableViewDataSource> {
    NSArray *productArray;
    NSArray *prodDescArray;
    NSArray *productCodes;
    AppDelegate *app;
}

@property (strong, nonatomic) NSArray *content;

@end
