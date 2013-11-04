//
//  UIImageViewController.m
//  SandBox112
//
//  Created by Jeff Chau on 17/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import "UIImageViewController.h"
#import "UIInfoViewController.h"
#import "FDTakeController.h"
#import "AppDelegate.h"

#define HKID        1000
#define NAMECARD    1010
#define SALARY      1020
#define ADDRESS     1030

@interface UIImageViewController () <FDTakeDelegate>

@end

@implementation UIImageViewController
@synthesize imgView_hkid;
@synthesize imgView_nameCard;
@synthesize imgView_salary;
@synthesize imgView_address;
@synthesize photoControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) doTakePicHkid:(id) sender; {
    NSLog(@"button is clicked");
    
    UIButton *btn_send = (UIButton *) sender;
    photoControl.tag = [btn_send tag];
    [photoControl takePhotoOrChooseFromLibrary];
        
}

- (IBAction) doTakePicHkid {
    
    NSLog(@"Without sender");
    
}

/* - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imgView_hkid.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
} */

#pragma mark - FDTakeDelegate
- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    NSLog(@"callback");
    NSLog(@"%ld",(long)controller.tag);
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    switch (controller.tag) {
        case HKID:
            imgView_hkid.image = photo;
            [app.dict_img setObject:photo forKey:@"hkid"];
            break;
        case NAMECARD:
            imgView_nameCard.image = photo;
            [app.dict_img setObject:photo forKey:@"nameCard"];
            break;
        case SALARY:
            imgView_salary.image = photo;
            [app.dict_img setObject:photo forKey:@"salary"];
            break;
        case ADDRESS:
            imgView_address.image = photo;
            [app.dict_img setObject:photo forKey:@"address"];
            break;
    }
}

- (void)takeController:(FDTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt
{
    
    NSString *key;
    NSString* default_filename;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (madeAttempt == NO) {

        NSLog(@"Reset pressed");
        
        switch (controller.tag) {
            case HKID:
                key = @"hkid";
                default_filename = [[@"default_" stringByAppendingString:key] stringByAppendingString:@".jpg"];
                imgView_hkid.image = [UIImage imageNamed:default_filename];
                break;
            case NAMECARD:
                key = @"nameCard";
                default_filename = [[@"default_" stringByAppendingString:key] stringByAppendingString:@".jpg"];
                imgView_nameCard.image = [UIImage imageNamed:default_filename];
                break;
            case SALARY:
                key = @"salary";
                default_filename = [[@"default_" stringByAppendingString:key] stringByAppendingString:@".jpg"];
                imgView_salary.image = [UIImage imageNamed:default_filename];
                break;
            case ADDRESS:
                key = @"address";
                default_filename = [[@"default_" stringByAppendingString:key] stringByAppendingString:@".jpg"];
                imgView_address.image = [UIImage imageNamed:default_filename];
                break;
        }
        [app.dict_img removeObjectForKey:key];
        [self delCacheImage:key];
    }
}

- (void) delCacheImage:(NSString *)key {
    
    //Remove image saved to document folder
    NSString *fileToDel = [key stringByAppendingString:@".jpg"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    ;
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToDel = [documentsDirectory stringByAppendingPathComponent:fileToDel];
    NSError *error;
    BOOL success =[[NSFileManager defaultManager] removeItemAtPath:pathToDel error:&error];
    if (success) {
        NSLog(@"Delete successfully");
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imgView_hkid.contentMode = UIViewContentModeScaleAspectFit;
    imgView_nameCard.contentMode = UIViewContentModeScaleAspectFit;
    imgView_salary.contentMode = UIViewContentModeScaleAspectFit;
    imgView_address.contentMode = UIViewContentModeScaleAspectFit;
    
    photoControl = [[FDTakeController alloc] init];
    photoControl.delegate = self;
    
    //fetch from shared image dictionary
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImage *image = [app.dict_img objectForKey:@"hkid"];
    if (image != nil) {
        [imgView_hkid setImage:image];
    }
    
    image = [app.dict_img objectForKey:@"nameCard"];
    if (image != nil) {
        [imgView_nameCard setImage:image];
    }
    
    image = [app.dict_img objectForKey:@"salary"];
    if (image != nil) {
        [imgView_salary setImage:image];
    }
    
    image = [app.dict_img objectForKey:@"address"];
    if (image != nil) {
        [imgView_address setImage:image];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
