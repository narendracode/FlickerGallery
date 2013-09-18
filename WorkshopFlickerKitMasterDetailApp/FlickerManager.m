//
//  FlickerManager.m
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/6/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import "FlickerManager.h"
#import "FlickrKit.h"
#import "ImageDetail.h"
@implementation FlickerManager
@synthesize searchText;
-(void)getPhotos{
    self.photos = [[NSMutableArray alloc]init];// ;//= [[NSMutableArray alloc]init];
    
    NSString *apikey = @"2e6bb6e6e3dc4db067d4ab8c5bcaeb76";
    NSString *secret = @"3968857e6bcaa558";
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:apikey sharedSecret:secret];
    //FlickrKit *fk = [FlickrKit sharedFlickrKit];
    
    FKFlickrPhotosSearch *search = [[FKFlickrPhotosSearch alloc] init];
	search.text = self.searchText;
    NSLog(@"***********");
    [[FlickrKit sharedFlickrKit] call:search completion:^(NSDictionary *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (response) {
				//NSMutableArray *photoURLs = [NSMutableArray array];
                
				for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
					
                   //NSLog(@"URL:%@",[[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData]);
                    
                    ImageDetail *imageDetail = [[ImageDetail alloc]init];
                     imageDetail.url = [[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
                    imageDetail.title = [photoData valueForKey:@"title" ];
                    imageDetail.imageId = [[photoData valueForKey:@"id"] integerValue];
                    imageDetail.farm = [photoData valueForKey:@"farm"];
                    imageDetail.isfamily = [photoData valueForKey:@"isfamily"];
                    imageDetail.isfriend = [photoData valueForKey:@"isfriend"];
                    imageDetail.ispublic = [photoData valueForKey:@"ispublic"];
                    imageDetail.owner = [photoData valueForKey:@"owner"];
                    imageDetail.secret = [photoData valueForKey:@"secret"];
                    imageDetail.server = [photoData valueForKey:@"server"];
                    
                    [self.photos addObject:imageDetail];
                    NSLog(@"TOtal number of photos parsed------:%d",[self.photos count]);
                    
                   // NSURL *url = [[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
					//[photoURLs addObject:url];
                    
                   // NSLog(@"%@",photoData);
                    // NSLog(@"%@", url);
                    //NSString *title = [photoData valueForKey:@"title" ];
                    //NSLog(@"Title:%@",title);
				}
                NSLog(@"TOtal number of photos parsed######:%d",[self.photos count]);
                
                
			} else {
				/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alert show];*/
                NSLog(@"No photos found");
                
                
			}
		});
	}];
 
  NSLog(@"TOtal number of photos parsed @@@@@@@:%d",[self.photos count]);   
    //NSLog(@"TOtal number of photos parsed:%d",[self.photos count]);
    //return self.photos;
}
@end
