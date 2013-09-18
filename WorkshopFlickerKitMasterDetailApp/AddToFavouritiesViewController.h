//
//  AddToFavouritiesViewController.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/10/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDetail.h"
#import "sqlite3.h"
#import "FavouriteDBUtil.h"
@interface AddToFavouritiesViewController : UIViewController//<UINavigationControllerDelegate>
{
    sqlite3 *favouriteDB;
    NSString *databasePath;

}
@property (weak, nonatomic) IBOutlet UIImageView *favouriteImage;
@property (weak, nonatomic) IBOutlet UITextField *favouriteTitle;
@property (weak,nonatomic) IBOutlet UITextField *comment;
@property (strong,nonatomic) FavouriteDBUtil *favouriteDBUtil;
@property (strong, nonatomic) id detailItem;
@property ImageDetail *imageDetail;
- (IBAction)saveFavourite:(id)sender;
-(IBAction)cancel:(id)sender;
-(void)createDB;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
@end
