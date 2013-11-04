//
//  UICompleteViewController.m
//  SandBox112
//
//  Created by Jeff Chau on 24/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import "UICompleteViewController.h"

@interface UICompleteViewController ()

@end

@implementation UICompleteViewController

@synthesize docArray;
@synthesize checkListView;
@synthesize checkListHeader;
@synthesize refNumStr;
@synthesize refNum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {

    checkListView.dataSource = self;
    
    //no pending document
    if ([docArray count] == 0) {
        [checkListHeader setHidden:TRUE];
        [checkListView setHidden:TRUE];
    }
    
    self.navigationItem.hidesBackButton = YES;
    [refNum setText:refNumStr];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [docArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier = @"SettingsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSString *doc = [self.docArray objectAtIndex:indexPath.row];
    
    
    [cell.textLabel setText:NSLocalizedStringFromTable(doc, @"LoanApp",@"Desc of docs")];
    
    cell.textLabel.textColor = [UIColor redColor];
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
