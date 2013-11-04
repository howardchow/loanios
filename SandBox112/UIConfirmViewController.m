//
//  UIConfirmViewController.m
//  SandBox112
//
//  Created by Jeff Chau on 18/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import "UIConfirmViewController.h"

@interface UIConfirmViewController ()

@end

@implementation UIConfirmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
