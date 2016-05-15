//
//  SignUpViewController.h
//  Base
//
//  Created by Blake Nazario on 4/21/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate> {
    NSString *passwordString;
    
    BOOL emailIsValid;
}

@property (strong, nonatomic) UINavigationController *parentNavController;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewForLayout;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *setupAccountButton;

- (IBAction)setupAccountAction:(id)sender;
- (IBAction)openPrivacyPolicy:(id)sender;

@end
