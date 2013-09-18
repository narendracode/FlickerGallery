//
//  SharePhotographViewController.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/10/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharePhotographViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) UIImage *image;

- (IBAction)shareFromGallery:(id)sender;
-(IBAction)capturePicture:(id)sender;
- (void)showActivityViewController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
