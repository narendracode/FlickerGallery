//
//  WeatherLocationManager.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/12/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
#import <CoreLocation/CoreLocation.h>
@interface WeatherLocationManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager ;
    CLLocation *lastLocation;
    Weather *weather;
}
-(void) locateMe;
-(void) findWeather;
@property float lattitude;
@property float longitude;
@property NSString *address;
@property Weather *weather;
@end
