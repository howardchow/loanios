//
//  UIInfoViewController.h
//  SandBox112
//
//  Created by Jeff Chau on 17/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWForm.h"
#import "Validator.h"
#import "AppDelegate.h"

#define ALPHA                   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMERIC                 @"1234567890"
#define ALPHA_NUMERIC           ALPHA NUMERIC
#define EMAIL                   1001
#define PHONE                   1002
#define NUMBER                  1003
#define IDNUM                   1004

@interface UIInfoViewController : UIViewController<UITextFieldDelegate, UIPopoverControllerDelegate> {
    IBOutlet UITextField *txt_hkid;
    IBOutlet UITextField *txt_loanAmt;
    IBOutlet UITextField *txt_phone;
    IBOutlet UITextField *txt_email;
    IBOutlet UILabel *msg_hkid;
    IBOutlet UILabel *msg_loanAmt;
    IBOutlet UILabel *msg_phone;
    IBOutlet UILabel *msg_email;
    IBOutlet UIButton *submit_btn;
    IBOutlet UIButton *server_btn;
    IBOutlet UIProgressView *view_progress;
    

    __block NSNumber *refNum;
    NWForm *htmlForm;
    Validator *validator;
    UIPopoverController* popoverController;
    NSMutableDictionary *dict_input;
    AppDelegate *app;
    
}

@property (nonatomic,retain) IBOutlet UITextField *txt_hkid;
@property (nonatomic,retain) IBOutlet UITextField *txt_loanAmt;
@property (nonatomic,retain) IBOutlet UITextField *txt_phone;
@property (nonatomic,retain) IBOutlet UITextField *txt_email;
@property (nonatomic,retain) IBOutlet UIButton *submit_btn;
@property (nonatomic,retain) IBOutlet UIButton *server_btn;

@property (nonatomic,retain) IBOutlet UILabel *msg_email;

@property (nonatomic,retain) IBOutlet
UIProgressView *view_progress;

@property (nonatomic, retain) __block NSNumber *refNum;
@property (nonatomic,retain) NWForm *htmlForm;
@property (nonatomic, retain) AppDelegate *app;
@property (nonatomic,retain) Validator* validator;
@property (nonatomic,retain) UIPopoverController* popoverController;

- (IBAction) submit_onClick: (id) sender;
- (IBAction) server_onClick: (id) sender;

@end
