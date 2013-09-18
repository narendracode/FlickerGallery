//
//  DetailViewController.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/5/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDetail.h"
@interface DetailViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property ImageDetail *imageDetail;
- (IBAction)shareFacebook:(id)sender;

- (IBAction)shareTwitter:(id)sender;
- (void)showActivityViewController;
@end
