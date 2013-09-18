//
//  FlickerManager.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/6/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrKit.h"
@interface FlickerManager : NSObject
@property NSMutableArray *photos;
@property NSString *searchText;
//-(NSArray*)getPhotos;
-(void)getPhotos;
@end
