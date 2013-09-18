//
//  WeatherViewController.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/10/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherLocationManager.h"
@interface WeatherViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property WeatherLocationManager *wLocationmanager;
@end
