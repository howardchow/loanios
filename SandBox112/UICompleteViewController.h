//
//  UICompleteViewController.h
//  SandBox112
//
//  Created by Jeff Chau on 24/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICompleteViewController : UIViewController<UITableViewDataSource> {
    NSArray *docArray;
    IBOutlet UITableView *checkListView;
    IBOutlet UILabel *checkListHeader;
    IBOutlet UILabel *refNum;
    NSString *refNumStr;
}

@property (strong, nonatomic) NSArray *docArray;
@property (strong, nonatomic) IBOutlet UITableView *checkListView;
@property (nonatomic, retain) IBOutlet UILabel *checkListHeader;
@property (nonatomic, retain) IBOutlet UILabel *refNum;
@property (nonatomic, retain) NSString *refNumStr;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
