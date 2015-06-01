//
//  ViewController.h
//  jcivwp
//
//  Created by 179159 on 14/05/15.
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WindowsAzureMessaging/WindowsAzureMessaging.h>

@class TPKeyboardAvoidingScrollView;


@interface ViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic,strong) IBOutlet UIButton *loginButton;
@property (nonatomic,strong) IBOutlet UITextField *userName;
@property (nonatomic,strong) IBOutlet UITextField *userPassword;

@end
