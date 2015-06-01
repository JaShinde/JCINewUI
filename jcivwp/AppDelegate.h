//
//  AppDelegate.h
//  jcivwp
//
//  Created by 179159 on 14/05/15.
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WindowsAzureMessaging/WindowsAzureMessaging.h>

//@class DashboardViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>



@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *materialList;
@property (strong, nonatomic) NSDictionary *response;
@property (strong, nonatomic) NSDictionary *lookupTable;
//@property (strong, nonatomic) DashboardViewController *dashboardViewController;


@end
