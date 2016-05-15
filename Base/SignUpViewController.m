//
//  SignUpViewController.m
//  Base
//
//  Created by Blake Nazario on 4/21/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "SignUpViewController.h"

#import "UITextField+EmailValidation.h"

@interface SignUpViewController ()
@property (strong, nonatomic) NSDictionary *fontAttributesDict;
@end

@implementation SignUpViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.emailTextField becomeFirstResponder];
    [self autoScrollView:_viewForLayout onScrollView:_scrollView forEditing:YES withTextField:_passwordTextField];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[self navigationController]setNavigationBarHidden:NO animated:NO];

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self.navigationItem setTitle:@"Sign Up"];
    
    [self setFontAttributes];
    
    [self setUI];
    [self setTextFields];
    
    [_activityIndicator setHidesWhenStopped:YES];
    [_activityIndicator stopAnimating];
}

- (void)setFontAttributes {
    UIFont *font = [UIFont systemFontOfSize:17.0f];
    UIColor *forgroundColor = [UIColor colorWithRed:255/255.0 green:68/255.0 blue:74/255.0f alpha:1.0];
    UIColor *backgroundColor = [UIColor whiteColor];
    
    
    self.fontAttributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                     font, NSFontAttributeName,
                                     forgroundColor, NSForegroundColorAttributeName,
                                     backgroundColor, NSBackgroundColorAttributeName,
                                     nil];
    
    NSLog(@"Font attributes: %@", _fontAttributesDict);
}

- (void)setUI {
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    
    self.setupAccountButton.layer.cornerRadius = 15.0f;
    self.setupAccountButton.clipsToBounds = YES;

    
    _scrollView.delegate = self;
    
    _scrollView.contentOffset = CGPointMake(0,0);
    CGPoint point = self.setupAccountButton.frame.origin ;
    _scrollView.contentOffset = point;
}

- (void)setTextFields {
    _emailTextField.tag = 100;
    _passwordTextField.tag = 200;
    self.confirmPasswordTextField.tag = 300;
    
    [_emailTextField addTarget:self action:@selector(textDidChangeForTextField:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(textDidChangeForTextField:) forControlEvents:UIControlEventEditingChanged];
    [_confirmPasswordTextField addTarget:self action:@selector(textDidChangeForTextField:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    //iPhone
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        
        if (textField.tag == 100) {
            //            NSLog(@"EMAIL");
            [_scrollView setScrollEnabled:NO];
            [self autoScrollView:_viewForLayout onScrollView:_scrollView forEditing:YES withTextField:_emailTextField];
        }
        
        else if (textField.tag == 200) {
            //            NSLog(@"PASSWORD");
            [_scrollView setScrollEnabled:NO];
            [self autoScrollView:_viewForLayout onScrollView:_scrollView forEditing:YES withTextField:_passwordTextField];
        }
        
        else if (textField.tag == 300) {
            //            NSLog(@"CONFIRM PASSWORD");
            
            [_scrollView setScrollEnabled:NO];
            [self autoScrollView:_viewForLayout onScrollView:_scrollView forEditing:YES withTextField:_confirmPasswordTextField];
        }
    }
    
    // iPad
    else {
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            
            NSLog(@"*** Register View Controller *** iPad is in landscape mode.");
            if (textField.tag == 100) {
                //                NSLog(@"EMAIL");
                [_scrollView setScrollEnabled:NO];
                [self autoScrollView:_viewForLayout onScrollView:_scrollView forEditing:YES withTextField:_emailTextField];
            }
            
            else if (textField.tag == 200) {
                //                NSLog(@"PASSWORD");
                [_scrollView setScrollEnabled:NO];
                [self autoScrollView:_viewForLayout onScrollView:_scrollView forEditing:YES withTextField:_passwordTextField];
            }
            
            else if (textField.tag == 300) {
                //                NSLog(@"CONFIRM PASSWORD");
                
                [_scrollView setScrollEnabled:NO];
                [self autoScrollView:_viewForLayout onScrollView:_scrollView forEditing:YES withTextField:_confirmPasswordTextField];
            }
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (textField.tag == 100) {
        [_passwordTextField becomeFirstResponder];
    }
    
    else if (textField.tag == 200) {
        [_confirmPasswordTextField becomeFirstResponder];
    }
    
    else if (textField.tag == 300) {
        [_confirmPasswordTextField endEditing:YES];
        [_confirmPasswordTextField resignFirstResponder];
        [self autoScrollView:_viewForLayout onScrollView:_scrollView forEditing:NO withTextField:nil];
    }
    
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (emailIsValid == YES &&
        _passwordTextField.text.length >= 8 &&
        [_confirmPasswordTextField.text isEqualToString:_passwordTextField.text])
    {
        [self.setupAccountButton setEnabled:YES];
        [self animateButton:self.setupAccountButton forChangeTo:@"white"];
        
        [self.errorLabel setHidden:YES];
//        self.instructionLabel.text = @"You may now create your account!";
//        [self.instructionLabel setHidden:NO];
    }
    
    if (textField.tag == 100) {
        emailIsValid = [UITextField checkIfEmailIsValid: _emailTextField.text];
        
        if (emailIsValid) {
            NSLog(@"*** Email is Valid");
            [self.errorLabel setHidden:YES];
        }
        
        else {

            [self animateLabelWithString:@" Email is Invalid "];
            [self.errorLabel setHidden:NO];
        }
    }
    
    else if (textField.tag == 200) {
        //        NSLog(@"Password field ended editing");
        NSLog(@"Password field: %@", _passwordTextField.text);
        
        if (_passwordTextField.text.length < 8) {
            [self.setupAccountButton setEnabled:NO];
            [self animateButton:self.setupAccountButton forChangeTo:@"gray"];
            
            [self animateLabelWithString:@" Password must be at least 8 characters "];
            [self.errorLabel setHidden:NO];
            
//            _passwordCheckImageView.image = [UIImage imageNamed:@"Register-Invalid.png"];
//            [self animateImage:_passwordCheckImageView forAnimationFade:YES];
        }
        
        else if (_passwordTextField.text.length >= 8) {
            
//            _passwordCheckImageView.image = [UIImage imageNamed:@"Register-Checkmark.png"];
//            [self animateImage:_passwordCheckImageView forAnimationFade:YES];
            passwordString = _passwordTextField.text;
        }
    }
    
    else if (textField.tag == 300){
        if (![_confirmPasswordTextField.text isEqualToString: _passwordTextField.text]) {
            //            NSLog(@"Confirm password is invalid");
            
            [self.setupAccountButton setEnabled:NO];
            [self animateButton:self.setupAccountButton forChangeTo:@"gray"];
            
            [self animateLabelWithString:@" Passwords do not match "];
//            _confirmPasswordCheckImageView.image = [UIImage imageNamed:@"Register-Invalid.png"];
            
            [self.errorLabel setHidden:NO];
//            [self animateImage:_confirmPasswordCheckImageView forAnimationFade:YES];
        }
        
        else if ([_confirmPasswordTextField.text isEqualToString:_passwordTextField.text] &&
                 _passwordTextField.text.length < 8) {
            
            [self.setupAccountButton setEnabled:NO];
            [self animateButton:self.setupAccountButton forChangeTo:@"gray"];
            
//            _confirmPasswordCheckImageView.image = [UIImage imageNamed:@"Register-Invalid.png"];
//            [self animateImage:_confirmPasswordCheckImageView forAnimationFade:YES];
        }
        
        else if ([_confirmPasswordTextField.text isEqualToString:_passwordTextField.text]) {
//            _confirmPasswordCheckImageView.image = [UIImage imageNamed:@"Register-Checkmark.png"];
            
//            [self animateImage:_confirmPasswordCheckImageView forAnimationFade:YES];
        }
    }
    
    if (UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"Swipe gesture from keyboard method");
        [self autoScrollView:_viewForLayout onScrollView:_scrollView forEditing:NO withTextField:_emailTextField];
    }
}

- (void)textDidChangeForTextField:(UITextField*)textField {
    if (textField.tag == 100) {
        //        NSLog(@"TEXT CHANGE FOR EMAIL");
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789@."]
                                invertedSet];
        
        if ([_emailTextField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
            //            NSLog(@"This string contains illegal characters");
            self.errorLabel.attributedText = [[NSAttributedString alloc] initWithString:@"Illegal character in email field"];
            [self.errorLabel setHidden:NO];
//            _emailCheckImageView.image = [UIImage imageNamed:@"Register-Invalid.png"];
//            
//            [self animateImage:_emailCheckImageView forAnimationFade:NO];
        }
        
        else if ([_emailTextField.text rangeOfCharacterFromSet:set].location == NSNotFound) {
            [self.errorLabel setHidden:YES];
//            _emailCheckImageView.image = nil;
//            [self animateImage:_emailCheckImageView forAnimationFade:NO];
        }
    }
    
    if (textField.tag == 200) {
        if (_passwordTextField.text.length > 0) {
            [self.errorLabel setHidden:YES];
//            _passwordCheckImageView.image = nil;
//            [self animateImage:_passwordCheckImageView forAnimationFade:NO];
        }
    }
    
    if (textField.tag == 300) {
        if (_confirmPasswordTextField.text.length > 0) {
            [self.errorLabel setHidden:YES];
//            _confirmPasswordCheckImageView.image = nil;
//            [self animateImage:_confirmPasswordCheckImageView forAnimationFade:NO];
        }
        
        if (_passwordTextField.text.length > 7) {
            
            if (emailIsValid == YES && _passwordTextField.text.length >= 8 && _confirmPasswordTextField.text.length >= 8) {
                [self.setupAccountButton setEnabled:YES];
                [self animateButton:self.setupAccountButton forChangeTo:@"blue"];
                
                [self.errorLabel setHidden:YES];
            }
        }
        
        if (_confirmPasswordTextField.text.length < 8) {
            [self.setupAccountButton setEnabled:NO];
            [self animateButton:self.setupAccountButton forChangeTo:@"gray"];
        }
    }
}


#pragma mark - ScrollView Delegate

- (void) autoScrollView:(UIView *)view onScrollView:(UIScrollView *)scrollView forEditing:(BOOL)editing withTextField:(UITextField*)textField{
    NSLog(@"Autoscrolling scroll view");
    
    float slidePoint = 0.0f;
    float keyBoard_Y_Origin;
    CGPoint pointToReturnTo = CGPointMake(0, 0);
    
    // iPhone
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        keyBoard_Y_Origin = self.scrollView.bounds.size.height - 216.0f;
    }
    
    // iPad
    else {
        keyBoard_Y_Origin = self.view.bounds.size.height / 2;
    }
    
    
    if (editing == YES) {
        NSLog(@"Did Begin Editing for tag: %ld", (long)textField.tag);
        
        // Only scroll if the text field is behind the keyboard
        if (textField.frame.origin.y > _viewForLayout.superview.frame.size.height - keyBoard_Y_Origin - textField.frame.size.height) {
        
            if (textField.tag == 100) {
                float viewBottomPoint = _viewForLayout.superview.frame.origin.y + (textField.frame.origin.y + textField.frame.size.height);
                
                slidePoint = viewBottomPoint - keyBoard_Y_Origin + 100;
                CGPoint point = CGPointMake(0.0f, slidePoint);
                pointToReturnTo = point;
                
                [_scrollView setContentOffset:point animated:YES];
                
                NSLog(@"content offset: %@", NSStringFromCGPoint(_scrollView.contentOffset));
            }
            
            else if (textField.tag == 200) {
                float viewBottomPoint = _viewForLayout.superview.frame.origin.y + (textField.frame.origin.y + textField.frame.size.height);
                
                slidePoint = viewBottomPoint - keyBoard_Y_Origin + 70;
                CGPoint point = CGPointMake(0.0f, slidePoint);
                pointToReturnTo = point;
                
                [_scrollView setContentOffset:point animated:YES];
                
                NSLog(@"content offset: %@", NSStringFromCGPoint(_scrollView.contentOffset));
            }
            
            else if (textField.tag == 300) {
                float viewBottomPoint = _viewForLayout.superview.frame.origin.y + (self.setupAccountButton.frame.origin.y + self.setupAccountButton.frame.size.height);
                
                slidePoint = viewBottomPoint - keyBoard_Y_Origin + 20;
                CGPoint point = CGPointMake(0.0f, slidePoint);
                pointToReturnTo = point;
                
                [_scrollView setContentOffset:point animated:YES];
                
                NSLog(@"content offset: %@", NSStringFromCGPoint(_scrollView.contentOffset));
            }
        }
    }
    
    else if (editing == NO) {
        
        NSLog(@"Editing == no");
        [_scrollView setContentOffset:pointToReturnTo animated:YES];
        NSLog(@"content offset: %@", NSStringFromCGPoint(_scrollView.contentOffset));
    }
}


#pragma mark - Animation

- (void)animateImage:(UIImageView*)image forAnimationFade:(BOOL)fadeIn{
    
    if (fadeIn == YES) {
        image.alpha = 0;
        [UIView animateWithDuration:.2 animations:^{
            image.alpha = 1;
        }];
    }
    
    else if (fadeIn == NO){
        image.alpha = 1;
        
    }
}

- (void)animateButton:(UIButton*)button forChangeTo:(NSString*)color {
    if ([color isEqualToString:@"white"]) {
        [UIView animateWithDuration:.4 animations:^{
            [self.setupAccountButton setBackgroundColor:[UIColor whiteColor]];
            [UIView commitAnimations];
        }];
    }
    
    else if ([color isEqualToString:@"gray"]) {
        if (self.setupAccountButton.backgroundColor != [UIColor lightGrayColor]) {
            [UIView animateWithDuration:.4 animations:^{
                [self.setupAccountButton setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3]];
                [UIView commitAnimations];
            }];
        }
    }
}

- (void)animateLabelWithString:(NSString*)string {
//    [UIView animateWithDuration: .4 animations:^{
//        [_errorLabel setAttributedText:[[NSAttributedString alloc]initWithString:string
//                                                                      attributes:_fontAttributesDict]];
//        [UIView commitAnimations];
//    }];

    CATransition *animation = [CATransition animation];
    animation.duration = .4;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.errorLabel.layer addAnimation:animation forKey:@"changeTextTransition"];

    [_errorLabel setAttributedText:[[NSAttributedString alloc]initWithString:string
                                                                  attributes:_fontAttributesDict]];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)setupAccountAction:(id)sender {
    [self performSegueWithIdentifier:@"SetupAccountSegue" sender:self];
}

- (IBAction)openPrivacyPolicy:(id)sender {
}
@end
