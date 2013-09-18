//
//  WeatherLocationManager.m
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/12/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import "WeatherLocationManager.h"

@implementation WeatherLocationManager
{
   
    CLLocation *myLocation ;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.weather = [[Weather alloc]init];
        
        locationManager = [[CLLocationManager alloc]init];
        [locationManager setDelegate:self];
        [locationManager startUpdatingLocation];
        myLocation = [locationManager location];
        //[myLocation coordinate];
        self.lattitude = myLocation.coordinate.latitude;
        self.longitude = myLocation.coordinate.longitude;
       

    }
    return self;
}
@synthesize longitude,lattitude,address,weather;

-(void) locateMe{
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:myLocation completionHandler:^(NSArray *placemarks, NSError *error){
        
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSArray *FormattedAddressLinesArr = [placemark.addressDictionary objectForKey:(@"FormattedAddressLines")];
        self.address = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@",[FormattedAddressLinesArr objectAtIndex:0],[FormattedAddressLinesArr objectAtIndex:1],[FormattedAddressLinesArr objectAtIndex:2],[placemark.addressDictionary objectForKey:@"City"],[placemark.addressDictionary objectForKey:@"State"],[placemark.addressDictionary objectForKey:@"Country"]];
         NSLog(@"Address in locate me: %@",self.address);
    }];//geocoder
}

-(void) findWeather{
    NSString *urlString = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v1/weather.ashx?key=8sa339u7aukwk5qxr8mjp5vg&q=%f,%f&fx=no&format=json",lattitude,longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    
   // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        [self fetchedData:data];
        
   // });

}

- (void)fetchedData:(NSData *)responseData {
   // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Fetch data called");
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        NSDictionary *myData = [json objectForKey:@"data"];
        NSArray *curr = [myData objectForKey:@"current_condition"];
        NSDictionary *currentDict = [curr objectAtIndex:0];
        
        weather.cloudcover = [currentDict objectForKey:@"cloudcover"];
        weather.humidity = [currentDict objectForKey:@"humidity"];
        weather.precipMM = [currentDict objectForKey:@"precipMM"];
        weather.pressure = [currentDict objectForKey:@"pressure"];
        weather.temp_C = [currentDict objectForKey:@"temp_C"];
        weather.temp_F = [currentDict objectForKey:@"temp_F"];
        
        
        NSArray *weatherDescArr = [currentDict objectForKey:@"weatherDesc"];
        NSDictionary *weatherDescDict = [weatherDescArr objectAtIndex:0];
        weather.weatherDesc = [weatherDescDict objectForKey:@"value"];
        
        NSArray *weatherIconUrlArr = [currentDict objectForKey:@"weatherIconUrl"];
        NSDictionary *weatherIconUrlDict = [weatherIconUrlArr objectAtIndex:0];
        weather.iconUrl = [weatherIconUrlDict objectForKey:@"value"];
        
        weather.winddirDegree =  [currentDict objectForKey:@"winddirDegree"];
        weather.windspeedKmph = [currentDict objectForKey:@"windspeedKmph"];
        
       // NSLog(@"URL: %@",weather.iconUrl);
   // });
}

@end
