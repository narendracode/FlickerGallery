//
//  WeatherViewController.m
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/10/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//


#import "WeatherViewController.h"
#import "SWRevealViewController.h"
#import "JSON.h"
#import "Weather.h"
#import "WeatherLocationManager.h"
@interface WeatherViewController ()
{

    NSMutableData *buffer;
	NSURLConnection *conn;

  // WeatherLocationManager *weatherLocationManager;

}
@end

@implementation WeatherViewController
@synthesize wLocationmanager;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);    
   // dispatch_async(queue, ^{
       // dispatch_group_t group = dispatch_group_create();
        
       // dispatch_group_async(group, queue, ^{
   // weatherLocationManager = [[WeatherLocationManager alloc]init];
   // [weatherLocationManager locateMe];
   // [weatherLocationManager findWeather];
            //NSLog(@"@@@@@@");
       // });
       // dispatch_group_notify(group, queue, ^{
     // dispatch_async(dispatch_get_main_queue(), ^{
          [self.tableView reloadData];
           //NSLog(@"@@@@@@######");
     // });//main
      //  });//group notify
  //  });//async
        
   // NSLog(@"Address: %@",weatherLocationManager.address);
    
    self.title = @"Location";
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
   // NSLog(@"before sleep");
    //[self performSelector:@selector(numberOfRowsInSection) withObject:self afterDelay:2.0 ];
    //NSLog(@"after sleep");
    // dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    //});
    
}//viewDidLoad






#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (section==0) {
        return  1;
    }else{
        return 8;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
    UITableViewCell *cell = [super tableView:tableView  cellForRowAtIndexPath:indexPath];
    
  
    switch (indexPath.section) {
        case 0:
        {
            
            switch (indexPath.row) {
                case 0:{
                    //NSLog(@"CHECK POINT:1");
                     UILabel *labelAddress = (UILabel *)[cell viewWithTag:1];
                    NSLog(@"CHECK POINT:2 %@",wLocationmanager.address);
                    labelAddress.text = wLocationmanager.address;
                   
                     //NSLog(@"CHECK POINT:3 :: %@", weatherLocationManager.weather.humidity);
                                       
                    
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
           // NSLog(@"SECTION 2 enter");
        
            switch (indexPath.row) {
                                 case 0:{
                                     
                                     UILabel *labelDesc = (UILabel *)[cell viewWithTag:3];
                                     labelDesc.text = wLocationmanager.weather.weatherDesc;
                                     
                    UIImageView *imageView = (UIImageView *)[cell viewWithTag:2];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSLog(@"URL ****: %@",wLocationmanager.weather.iconUrl);
                        NSURL *url = [NSURL URLWithString:wLocationmanager.weather.iconUrl];
                        
                       // UIImage* myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                          UIImage* myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [imageView setImage:myImage];
                        });
                    });

                    break;
                }
                case 1:{
                    //11
                    UILabel *labelTemp = (UILabel *)[cell viewWithTag:11];
                    labelTemp.text = wLocationmanager.weather.temp_C;
                   // cell.textLabel.text = wLocationmanager.weather.temp_C;
                    //cell.accessibilityValue = wLocationmanager.weather.temp_C;;
                    break;
                }
                case 2:{
                    UILabel *humidity = (UILabel *)[cell viewWithTag:12];
                   
                     humidity.text = wLocationmanager.weather.humidity;
                    break;
                }
                case 3:{
                     UILabel *cloudcover = (UILabel *)[cell viewWithTag:13];
                    cloudcover.text = wLocationmanager.weather.cloudcover;
                    break;
                }
                case 4:{
                    UILabel *pressure = (UILabel *)[cell viewWithTag:14];

                    pressure.text = wLocationmanager.weather.pressure;
                    break;
                }
                case 5:{
                     UILabel *precipMM = (UILabel *)[cell viewWithTag:15];
                     precipMM.text = wLocationmanager.weather.precipMM;
                    break;
                }
                case 6:{
                     UILabel *windspeedKmph = (UILabel *)[cell viewWithTag:16];
                     windspeedKmph.text = wLocationmanager.weather.windspeedKmph;
                    break;
                }
                case 7:{
                    UILabel *winddirDegree = (UILabel *)[cell viewWithTag:17];
                    winddirDegree.text = wLocationmanager.weather.winddirDegree;
                    break;
                }
                default:
                    break;
            }
            break;
        }

            
        default:
            break;
    }

    return cell;
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
