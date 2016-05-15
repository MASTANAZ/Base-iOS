//
//  AccountSettingsViewController.m
//  Base
//
//  Created by Blake Nazario on 4/21/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "AccountSettingsViewController.h"
#import "RSKImageCropper.h"
#import "ImageManipulator.h"

#import "NSUserDefaultsAPI.h"

@interface AccountSettingsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AccountSettingsViewController

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"View will appear");
    [_profileImageView setAlpha:0.0];
    [_editImageButton setAlpha:0.0];
    
    NSLog(@"Alpha for image: %f; button: %f", _profileImageView.alpha, _editImageButton.alpha);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [imagePickerController setAllowsEditing:NO];
    
    [self retrieveDataFromDefaults];
}

- (void)retrieveDataFromDefaults {
    UIImage *defaultsProfileImage = [[NSUserDefaultsAPI sharedInstance] retrieveProfileImageFromDefaults];
    
    if (defaultsProfileImage) {
        [self.profileImageView setImage:defaultsProfileImage];
        
        if (_editImageButton.alpha == 0.0 || _profileImageView.alpha == 0.0) {
            
            [self.profileImageView.layer setCornerRadius: .5 * self.profileImageView.frame.size.width];
            [self.profileImageView setClipsToBounds:YES];
            [UIView animateWithDuration:.4 animations:^{
                
                [_profileImageView setAlpha:1.0];
                [_editImageButton setAlpha:1.0];
                
                [UIView commitAnimations];
            }];
        }
    }
    
    else {
        // download image.
        
        // Temporary
        [self.profileImageView setImage: nil];
    }
}

#pragma mark - NOTE: The code here will change to load when the user's image is loaded from defaults.
- (void)viewDidLayoutSubviews {
    NSLog(@"View did lay out subviews");
    if (_editImageButton.alpha == 0.0 || _profileImageView.alpha == 0.0) {
        
        [self.profileImageView.layer setCornerRadius: .5 * self.profileImageView.frame.size.width];
        [self.profileImageView setClipsToBounds:YES];
        [UIView animateWithDuration:.4 animations:^{
            
            [_profileImageView setAlpha:1.0];
            [_editImageButton setAlpha:1.0];
            
            [UIView commitAnimations];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AccountCell"];
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Image Picker Controller

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        imageCropVC.delegate = self;
        [self.navigationController pushViewController:imageCropVC animated:YES];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        imageCropVC.delegate = self;
        [picker.navigationController pushViewController:imageCropVC animated:YES];
        
        [popover dismissPopoverAnimated:YES];
    }
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Crop VC
//TODO: The end of this method is where the code will be executed to update the image on the server.
//      The app will also store the photo to NSUserDefaults so it will not need to download it. (see
//      code for downloading profile images in the feed for reference.)
//
// NOTE:
//      There should also be code in place to notify the app that the image hasn't been saved to the server.
//      (e.g. a user is not connected to internet and would like to change their profile image)
//
//      However, an upload should only be uploaded when the user can connected to the internet; it should run a check
//      to make sure an upload is possible. If not, the app will not attempt an upload and instead just save the photo
//      to the NSUserDefaults as normal.
//
//      In this case, the app will update the image normally in user defaults, but have a tag that it hasn't been updated
//      on the server yet. When the tag shows that it is pending upload to the server, the app will then execute code to
//      commit an upload.
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect {
    
    // Resize image so when it is stored on the server, it doesn't take too much space.
    croppedImage = [UIImage imageWithImage:croppedImage scaledToSize:CGSizeMake(500.0, 500.0)];
    
    
    [[NSUserDefaultsAPI sharedInstance] saveProfileImageToDefaultsWithImage:croppedImage
                                                            completionBlock:^(BOOL success, NSError *error)
    {
        if (success) {
//            [self.profileImageView setImage:croppedImage];
            [self retrieveDataFromDefaults];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        else if (error) {
            NSLog(@"%@", error);
        }
        
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Error saving image" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
            
            [alert show];
        }
    }];
    

}


#pragma mark - Actions

- (IBAction)editImageAction:(id)sender {
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:imagePickerController animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:imagePickerController];
        [popover presentPopoverFromRect:self.editImageButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}
@end
