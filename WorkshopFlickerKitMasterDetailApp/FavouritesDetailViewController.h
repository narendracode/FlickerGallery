//
//  FavouritesDetailViewController.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/11/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDetail.h"
#import "FavouriteCell.h"
#import "FavouriteDBUtil.h"
@interface FavouritesDetailViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong,nonatomic) FavouriteDBUtil *favouriteDBUtil;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *favouriteImage;
@property (weak, nonatomic) IBOutlet UITextField *favouriteTitle;
@property (weak, nonatomic) IBOutlet UITextField *favouriteComment;
@property (weak,nonatomic) IBOutlet UIButton *save_edit;
- (IBAction)textFieldDoneEditing:(id)sender;
@property ImageDetail *imageDetail;
-(IBAction)saveFavourite:(id)sender;
@end
