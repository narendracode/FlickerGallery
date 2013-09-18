//
//  MasterViewController.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/5/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickerManager.h"
#import <AVFoundation/AVFoundation.h>
//#import "SWRevealViewController.h"
@interface MasterViewController : UIViewController<UISearchBarDelegate>{
@private
NSUInteger numberOfItemsToDisplay;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) FlickerManager *fm;
@property (nonatomic, strong) AVQueuePlayer *player;
@property (nonatomic, strong) id timeObserver;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UITableView *masterView;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak,nonatomic) IBOutlet UISearchBar *searchBar;
@end
