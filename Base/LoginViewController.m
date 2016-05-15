//
//  LoginViewController.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/26/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "LoginViewController.h"
#import "DGActivityIndicatorView.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet DGActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIImageView *base2ImageView;

@end

@implementation LoginViewController

DGActivityIndicatorView *activityView;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // re-hide the transparent nav bar if user swipes back
    [[self navigationController]setNavigationBarHidden:YES animated:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_usernameTextField becomeFirstResponder];
    
    [[self navigationController]setNavigationBarHidden:YES animated:NO];



    // Do any additional setup after loading the view.
    // [UIColor colorWithRed:255/255.0 green:68/255.0 blue:74/255.0 alpha:1.0]
    activityView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotate
                                                       tintColor:[UIColor colorWithRed:255/255.0 green:68/255.0 blue:74/255.0 alpha:1.0]
                                                            size:70.0f];
    
    //TODO: Get this to work with autolayout instead of manually setting the width. (Which is incorrect on all devices)
    //    [activityView setFrame:(CGRect){
    //                                    .origin = CGPointMake(.3825*self.view.frame.size.width, 82.0f),
    //                                    .size = self.base2ImageView.frame.size
    //                                   }
    //     ];
    
    
    [activityView setFrame:CGRectMake(0, 0, _base2ImageView.frame.size.width, _base2ImageView.frame.size.height)];
    [self.view addSubview:activityView];
    activityView.center = [self.view convertPoint:CGPointMake((.5 * self.view.frame.size.width) //- .5 * _base2ImageView.frame.size.width)
                                                              , _base2ImageView.center.y) fromView:_base2ImageView.superview];
    
    NSLog(@"Image center: %@\nAnimation center: %@", NSStringFromCGPoint(_base2ImageView.center), NSStringFromCGPoint(activityView.center));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpButtonTapped:(id)sender {

    
    [self performSegueWithIdentifier:@"SignUpSegue" sender:self];
}

- (IBAction)loginButtonTapped:(id)sender {

    [activityView setAlpha:0.0f];
    [activityView startAnimating];

    [UIView animateWithDuration:.3 animations:^{
        [activityView setAlpha:1.0f];
    }];
    
}


@end
