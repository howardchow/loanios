//
//  Validator.h
//  SandBox112
//
//  Created by Jeff Chau on 24/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

- (BOOL) validateEmail: (NSString *) txt;

// Text field related
- (void)highlight:(UITextField *) textField color:(UIColor *)inColor;
- (BOOL) checkRequired: (UITextField *) inText name:(NSString *) fieldName label:(UILabel*) tooltip;
- (BOOL) checkEmailFormat: (UITextField *) inText label:(UILabel *)tooltip;

@end
