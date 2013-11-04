//
//  UIInfoViewController.m
//  SandBox112
//
//  Created by Jeff Chau on 17/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIInfoViewController.h"
#import "NWForm.h"
#import "Validator.h"
#import "AppDelegate.h"
#import "UICompleteViewController.h"

@interface UIInfoViewController ()

@end

@implementation UIInfoViewController

@synthesize txt_hkid;
@synthesize txt_loanAmt;
@synthesize txt_phone;
@synthesize txt_email;
@synthesize htmlForm;
@synthesize validator;
@synthesize popoverController;
@synthesize msg_email;
@synthesize app;
@synthesize submit_btn;
@synthesize refNum;
@synthesize view_progress;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    htmlForm = [[NWForm alloc] init];
    [super viewDidLoad];
    txt_hkid.delegate = self;
    txt_hkid.tag = IDNUM;
    txt_loanAmt.delegate = self;
    txt_loanAmt.tag = NUMBER;
    txt_phone.delegate = self;
    txt_phone.tag = PHONE;
    txt_email.delegate = self;
    txt_email.tag = EMAIL;
    validator = [[Validator alloc] init];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    txt_hkid.text = app.dict_input[@"hkid"];
    txt_loanAmt.text = app.dict_input[@"loanamt"];
    txt_phone.text = app.dict_input[@"phone"];
    txt_email.text = app.dict_input[@"email"];
    
    [submit_btn setTitle:@"Please wait" forState:UIControlStateDisabled];
    
    [view_progress setHidden:YES];

}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self isMovingFromParentViewController]) {
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txt_hkid resignFirstResponder];
    [txt_loanAmt resignFirstResponder];
    [txt_phone resignFirstResponder];
    [txt_email resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag == IDNUM) {
        [validator checkRequired:txt_hkid name:@"HKID" label:msg_hkid];
        
        [app.dict_input setObject:txt_hkid.text forKey:@"hkid"];
    }
    
    if (textField.tag == NUMBER) {
        [validator checkRequired:txt_loanAmt name:@"Loan Amount" label:msg_loanAmt];
        
        [app.dict_input setObject:txt_loanAmt.text forKey:@"loanamt"];
    }
    
    if (textField.tag == PHONE) {
        [validator checkRequired:txt_phone name:@"Phone" label:msg_phone];
        
        [app.dict_input setObject:txt_phone.text forKey:@"phone"];
    }
    
    if (textField.tag == EMAIL) {
        
      if ([validator checkRequired:txt_email name:@"E-mail" label:msg_email]) {
          
          if ([validator checkEmailFormat:txt_email label:msg_email]) {
              [app.dict_input setObject:txt_email.text forKey:@"email"];
          }
          
      }
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *unacceptedInput = nil;
    switch (textField.tag) {
        case IDNUM:
            if (textField.text.length + string.length > 20) {
                return NO;
            }
            unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:ALPHA_NUMERIC] invertedSet];
            break;
        case EMAIL:
            if ([[textField.text componentsSeparatedByString:@"@"] count] > 1)
                unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:[ALPHA_NUMERIC stringByAppendingString:@".-"]] invertedSet];
            else
                unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:[ALPHA_NUMERIC stringByAppendingString:@".!#$%&'*+-/=?^_`{|}~@"]] invertedSet];
            break;
        case PHONE:
            if (textField.text.length + string.length > 8) {
                return NO;
            }
            unacceptedInput = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
            break;
        case NUMBER: {
            
            if (textField.text.length + string.length > 10) {
                return NO;
            }
            
            NSString *unformattedValue = [[textField.text stringByReplacingOccurrencesOfString:@"," withString:@""] stringByAppendingString:string];
            unformattedValue = [unformattedValue stringByReplacingOccurrencesOfString:@"." withString:@""];
            
            //backspace
            if ([string length] == 0) {
                if ([unformattedValue length] >= 1) {
                unformattedValue = [unformattedValue substringToIndex:[unformattedValue length] - 1];
                }
            }
            
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [formatter setGroupingSeparator:@","];
            [formatter setDecimalSeparator:@"."];
            
            NSNumber *amount = [NSNumber numberWithInteger:[unformattedValue intValue]];
            
            if ([amount longValue] == 0) {
                //field should be empty if nothing is entered
                textField.text = @"";
            } else {
                textField.text = [formatter stringFromNumber:amount];
            }
            return NO;
            break;
        } default:
            unacceptedInput = [[NSCharacterSet illegalCharacterSet] invertedSet];
            break;
    }
    return ([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1);
}

- (IBAction) server_onClick: (id) sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Development" message:@"server IP" delegate:self cancelButtonTitle:@"Hide" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeURL;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    htmlForm.serverAddr = [[alertView textFieldAtIndex:0] text];
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
}


- (IBAction) submit_onClick: (id) sender
{

    if (![htmlForm isNetworkOK]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Network" message: @"No connection" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        //Form Validaiton
        int errors = 0;
    
        if (![validator checkRequired:txt_hkid name:@"HKID" label:msg_hkid])
            errors++;
        if (![validator checkRequired:txt_loanAmt name:@"Loan amount" label:msg_loanAmt])
            errors++;
        if (![validator checkRequired:txt_phone name:@"Phone" label:msg_phone])
            errors++;
        if (![validator checkRequired:txt_email name:@"E-mail" label:msg_email]) {
            errors++;
        } else if (![validator checkEmailFormat:txt_email label:msg_email]) {
            errors++;
        }

        NSLog(@"%@ %@ %@ %@",txt_hkid.text,txt_loanAmt.text,txt_phone.text,txt_email.text);

        if (errors == 0) {

            //Remove comma of loan amount
            txt_loanAmt.text = [txt_loanAmt.text stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            NSDictionary *params = @{
           @"product":app.selectedProduct,
           @"hkid":txt_hkid.text,
           @"loanamt": txt_loanAmt.text,
           @"mobile": txt_phone.text,
           @"email" : txt_email.text
        };
        
        [submit_btn setHidden:YES];
        [view_progress setHidden:NO];
        [view_progress setProgress:0.0 animated:NO];
        
        [htmlForm postForm:params image:app.dict_img
        completion:^(NSNumber * inRef) {
            self.refNum = inRef;
            [submit_btn setHidden:NO];
            [view_progress setHidden:YES];
            [self performSegueWithIdentifier:@"submitServer" sender:self];
        }
        progress:^(float percentDone) {
            [view_progress setProgress:percentDone animated:YES];
        }];
        
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"submitServer"]) {
        //Prepare checklist
        NSArray*keys=[app.dict_img allKeys];
        NSString *picStr = @"hkid nameCard salary address";
        NSMutableArray *pendingArr = (NSMutableArray *) [picStr componentsSeparatedByString:@" "];
        [pendingArr removeObjectsInArray:keys];
    
        UICompleteViewController *controller = [segue destinationViewController];
        controller.docArray = pendingArr;
        controller.refNumStr = [@"Ref # : " stringByAppendingString:[self.refNum stringValue]];
    }
    
    
}


@end
