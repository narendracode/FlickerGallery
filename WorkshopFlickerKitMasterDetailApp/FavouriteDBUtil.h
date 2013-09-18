//
//  FavouriteDBUtil.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/11/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ImageDetail.h"
@interface FavouriteDBUtil : NSObject
{
    sqlite3 *favouriteDB;
}
@property (nonatomic, strong) NSString *databasePath;
- (void) initDatabase;
- (BOOL) saveFavourite:(ImageDetail *)favourite;
- (BOOL) deleteFavourite:(ImageDetail *)favourite;
- (NSMutableArray *) getFavourites;
- (ImageDetail *) getFavourite:(NSInteger) imageId;
@end
