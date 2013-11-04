//
//  AppDelegate.m
//  SandBox112
//
//  Created by Jeff Chau on 15/10/13.
//  Copyright (c) 2013 Jeff Chau. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize dict_input;
@synthesize dict_img;
@synthesize appFile;
@synthesize documentsDirectory;
@synthesize selectedProduct;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    appFile = [documentsDirectory stringByAppendingPathComponent:@"user.dict"];
    NSLog(@"User pref file : %@",appFile);
    
    dict_input = [[NSMutableDictionary alloc] initWithContentsOfFile:appFile];
    if (dict_input == nil) {
        dict_input = [[NSMutableDictionary alloc] init];
    }
    
    dict_img = [[NSMutableDictionary alloc] init];
    
    //load image into dict_img
    [self loadFromFile:@"hkid"];
    [self loadFromFile:@"nameCard"];
    [self loadFromFile:@"salary"];
    [self loadFromFile:@"address"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [dict_input writeToFile:appFile atomically:YES];
    
    for (NSString* dictkey in dict_img) {
        [self writeToImgFile:dictkey];
    }
    
}

- (void)loadFromFile:(NSString *)key {

    NSString *filename = [key stringByAppendingString:@".jpg"];
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:filename];
    UIImage *img;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        img = [[UIImage alloc] initWithContentsOfFile:filepath];
        [dict_img setObject:img forKey:key];
    } /*else {
        NSString *defaultname = [@"default_" stringByAppendingString:[key stringByAppendingString:@".jpg"]];
        img = [UIImage imageNamed:defaultname];
    }
    [dict_img setObject:img forKey:key];
    */
    
}

- (void)writeToImgFile:(NSString *)key {
    NSString *filename = [key stringByAppendingString:@".jpg"];
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:filename];
    NSData *imageData = UIImageJPEGRepresentation([dict_img objectForKey:key], 1.0);
    [imageData writeToFile:filepath atomically:YES];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
