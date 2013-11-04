//
//  Validator.m
//  SandBox112
//
//  Created by Jeff Chau on 24/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import "Validator.h"
#import <QuartzCore/QuartzCore.h>

@implementation Validator

- (BOOL) validateEmail: (NSString *) txt {
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    return [emailTest evaluateWithObject:txt];
}


- (void)highlight:(UITextField *) textField color:(UIColor *)incolor {
    textField.layer.borderColor = incolor.CGColor;
    textField.layer.borderWidth = 1.0;
    
}

- (BOOL) checkRequired: (UITextField *) inText name:(NSString *) fieldName label:(UILabel *)tooltip {
    
    if ([inText.text isEqualToString:@""]) {
        [self highlight:inText color:[UIColor redColor]];
        tooltip.text = @"Required";
        return NO;
    } else {
        [self highlight:inText color:[UIColor clearColor]];
        tooltip.text = @"";
        return YES;
    }
    
}

- (BOOL) checkEmailFormat: (UITextField *) inText label:(UILabel *)tooltip {

    BOOL result = [self validateEmail:inText.text];
    if (!result) {
        [self highlight:inText color:[UIColor redColor]];
        tooltip.text = @"Format:user@dns.com";
        return NO;
    } else {
        tooltip.layer.borderColor = [UIColor clearColor].CGColor;
        tooltip.text = @"";
        return YES;
    }
}


@end
