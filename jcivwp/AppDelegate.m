//
//  AppDelegate.m
//  jcivwp
//
//  Created by 179159 on 14/05/15.
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import "AppDelegate.h"
#import <WindowsAzureMessaging/WindowsAzureMessaging.h>
#import "MaterialList.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSLog(@"Come voer here");
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    self.materialList = [[NSMutableArray alloc] init];
    self.response = [[NSDictionary alloc]init];
    self.lookupTable = [[NSDictionary alloc]init];
    
    for (int i = 0; i<5; i++){
        
        MaterialList *ml = [[MaterialList alloc]init];
        ml.materialID = @"";
        ml.quantity = @"";
        ml.station = @"";
        ml.availability = @"";
        ml.delivery = @"";
        [self.materialList addObject:ml];
    }
    
//    self.dashboardViewController = [[DashboardViewController alloc]init];
    
    NSError *jsonError;
    NSData *objectData =[@"{\"1\":{\"source\":\"move_home\",\"dest\":\"NA\"},\"2\":{\"source\":\"move_store\",\"dest\":\"NA\"},\"3\":{\"source\":\"move_st1\",\"dest\":\"NA\"},\"4\":{\"source\":\"move_st2\",\"dest\":\"NA\"},\"5\":{\"source\":\"move_st3\",\"dest\":\"NA\"},\"6\":{\"source\":\"move_st4\",\"dest\":\"NA\"},\"7\":{\"source\":\"move_st5\",\"dest\":\"NA\"},\"8\":{\"source\":\"home\",\"dest\":\"store\"},\"9\":{\"source\":\"store\",\"dest\":\"station1\"},\"10\":{\"source\":\"store\",\"dest\":\"station2\"},\"11\":{\"source\":\"store\",\"dest\":\"station3\"},\"12\":{\"source\":\"store\",\"dest\":\"station4\"},\"13\":{\"source\":\"store\",\"dest\":\"station5\"},\"14\":{\"source\":\"station1\",\"dest\":\"station2\"},\"15\":{\"source\":\"station1\",\"dest\":\"station3\"},\"16\":{\"source\":\"station1\",\"dest\":\"station4\"},\"17\":{\"source\":\"station1\",\"dest\":\"station5\"},\"18\":{\"source\":\"station1\",\"dest\":\"home\"},\"19\":{\"source\":\"station2\",\"dest\":\"station3\"},\"20\":{\"source\":\"station2\",\"dest\":\"station4\"},\"21\":{\"source\":\"station2\",\"dest\":\"station5\"},\"22\":{\"source\":\"station2\",\"dest\":\"home\"},\"23\":{\"source\":\"station3\",\"dest\":\"station4\"},\"24\":{\"source\":\"station3\",\"dest\":\"station5\"},\"25\":{\"source\":\"station3\",\"dest\":\"home\"},\"26\":{\"source\":\"station4\",\"dest\":\"station5\"},\"27\":{\"source\":\"station4\",\"dest\":\"home\"},\"28\":{\"source\":\"station5\",\"dest\":\"home\"}}" dataUsingEncoding:NSUTF8StringEncoding];
    
    self.lookupTable = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&jsonError];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSString *str = [NSString stringWithFormat:@"Error %@",error];
    NSLog(@"%@",str);
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *) deviceToken {
    
/*    SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:
                              @"Endpoint=sb://agvnotifications-ns.servicebus.windows.net/;SharedAccessKeyName=DefaultListenSharedAccessSignature;SharedAccessKey=wpSfFqApLfH7LcQPOpPP0ZrdG24U56R9vs2VHSdHGxc=" notificationHubPath:@"agvnotifications"];
  */
    
    SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:
                              @"Endpoint=sb://agvnotificationhub-ns.servicebus.windows.net/;SharedAccessKeyName=DefaultListenSharedAccessSignature;SharedAccessKey=R8FPkHZav4yT2wbfGiFcMNc5N7vf55MoM/w86ONjaws=" notificationHubPath:@"agvnotificationhub"];
    
    
    
    NSLog(@"Device Tokern %@",deviceToken);
    //self.deviceToken = [[deviceToken d]];
    
    
    [hub registerNativeWithDeviceToken:deviceToken tags:nil completion:^(NSError* error) {
        
        if (error != nil) {
            NSLog(@"Error registering for notifications: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:
                                  @"Error While Registering" delegate:nil cancelButtonTitle:
                                  @"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:
                                  @"Registering" delegate:nil cancelButtonTitle:
                                  @"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification: (NSDictionary *)userInfo{
    NSLog(@"Received Notificaitons%@", userInfo);
    self.response = userInfo;
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:
//                              [[userInfo objectForKey:@"aps"] valueForKey:@"type"] delegate:nil cancelButtonTitle:
//                              @"OK" otherButtonTitles:nil, nil];
//        [alert show];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNotification" object:nil userInfo:userInfo];
    
//    [self.dashboardViewController parseResponse:[[userInfo objectForKey:@"aps"] valueForKey:@"type"]];

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
