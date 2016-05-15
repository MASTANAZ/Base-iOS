//
//  CreateAccountViewController.h
//  Base
//
//  Created by Blake Nazario on 4/21/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *baseOptionSegmentedControl;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;


- (IBAction)nextAction:(id)sender;

@end
