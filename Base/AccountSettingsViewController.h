//
//  AccountSettingsViewController.h
//  Base
//
//  Created by Blake Nazario on 4/21/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSKImageCropper.h"

@interface AccountSettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate>
{
    UIImagePickerController *imagePickerController;
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstLastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *baseLabel;

@property (weak, nonatomic) IBOutlet UITableView *optionsTable;

@property (weak, nonatomic) IBOutlet UIButton *editImageButton;

- (IBAction)editImageAction:(id)sender;
@end
