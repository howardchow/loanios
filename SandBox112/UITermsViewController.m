//
//  UITermsViewController.m
//  SandBox112
//
//  Created by Jeff Chau on 22/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import "UITermsViewController.h"

@interface UITermsViewController ()

@end

@implementation UITermsViewController

@synthesize btn_agree;
@synthesize btn_continue;
@synthesize txt_terms;
@synthesize checkBoxSelected;

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
    [txt_terms setContentInset:UIEdgeInsetsMake(-60.0, 0.0, 0.0, 0.0)];
	// Do any additional setup after loading the view.
    [btn_agree setBackgroundImage:[UIImage imageNamed:@"nonselected.png"]
                        forState:UIControlStateNormal];
    [btn_agree setBackgroundImage:[UIImage imageNamed:@"selected.png"]
                        forState:UIControlStateSelected];
    [btn_agree setBackgroundImage:[UIImage imageNamed:@"selected.png"]
                        forState:UIControlStateHighlighted];
    btn_agree.adjustsImageWhenHighlighted=YES;
    txt_terms.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txt_terms.layer.borderWidth = 1;
    checkBoxSelected = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) checkboxSelected:(id)sender
{
    checkBoxSelected = !checkBoxSelected;
    [btn_agree setSelected:checkBoxSelected];
}

- (IBAction) nextScreen:(id)sender;
{
    if (checkBoxSelected) {
        [self performSegueWithIdentifier:@"goDoc" sender:self];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Terms & Condition"
                                                        message:@"You must agree on terms and condition to proceed"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
