//
//  UITermsViewController.h
//  SandBox112
//
//  Created by Jeff Chau on 22/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITermsViewController : UIViewController {
    
    IBOutlet UIButton *btn_agree;
    IBOutlet UITextView *txt_terms;
    IBOutlet UIButton *btn_continue;
}

//There is no checkbox in iOS, this button simulate checkbox action
@property (nonatomic,retain) IBOutlet UIButton *btn_agree;
@property (nonatomic,retain) IBOutlet UITextView *txt_terms;
@property (nonatomic,retain) IBOutlet UIButton *btn_continue;

@property (nonatomic)BOOL checkBoxSelected;

- (IBAction) checkboxSelected:(id)sender;
- (IBAction) nextScreen:(id)sender;

@end
