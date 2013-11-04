//
//  UIImageViewController.h
//  SandBox112
//
//  Created by Jeff Chau on 17/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDTakeController.h"

@interface UIImageViewController : UIViewController {
      IBOutlet UIImageView *imgView_hkid;
      FDTakeController *photoControl;
}

@property (nonatomic,retain) IBOutlet UIImageView *imgView_hkid;
@property (nonatomic,retain) IBOutlet UIImageView *imgView_nameCard;
@property (nonatomic,retain) IBOutlet UIImageView *imgView_salary;
@property (nonatomic,retain) IBOutlet UIImageView *imgView_address;
@property (nonatomic, retain) FDTakeController *photoControl;


- (IBAction) doTakePicHkid:(id) sender;
- (IBAction) doTakePicHkid;
- (void) delCacheImage:(NSString *)key;

/*- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; */

@end
