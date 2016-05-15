//
//  LoginViewController.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/26/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)signUpButtonTapped:(id)sender;
- (IBAction)loginButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end
