//
//  FavouritesViewController.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/10/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "FavouriteDBUtil.h"
@interface FavouritesViewController : UITableViewController<UISearchBarDelegate>
{
        sqlite3 *favouriteDB;
        NSString *databasePath;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak,nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) FavouriteDBUtil *favouriteDBUtil;
@property (strong, nonatomic) NSMutableArray *favouritiesList;


@end
