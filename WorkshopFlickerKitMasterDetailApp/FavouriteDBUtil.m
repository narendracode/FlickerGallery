//
//  FavouriteDBUtil.m
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/11/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import "FavouriteDBUtil.h"

@implementation FavouriteDBUtil
@synthesize databasePath;

- (void) initDatabase {
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"favourite.sqlite"]];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if ([fileMgr fileExistsAtPath:databasePath]==NO) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &favouriteDB)==SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS FAVOURITES (ID INTEGER PRIMARY KEY AUTOINCREMENT, IMAGEURL TEXT, TITLE TEXT, COMMENT TEXT)";
            if (sqlite3_exec(favouriteDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
                // process error
                // NSLog(@"problems occured while creating database");
            }
            sqlite3_close(favouriteDB);
        }else{
            //lprocess error
        }
        NSLog(@"Exit createDB");
    }
}//initDatabase

-(BOOL)saveFavourite:(ImageDetail *)favourite{

     BOOL success = false;
    sqlite3_stmt *statement = NULL;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &favouriteDB) == SQLITE_OK)
    { 
        if (favourite.imageId >0) {
            NSLog(@"Exitsing data, Update Please");
            
            NSString *updateSQL = [NSString stringWithFormat:@"UPDATE FAVOURITES set IMAGEURL = '%@', COMMENT = '%@', TITLE = '%@' WHERE ID = ?",
                                   favourite.imageString,
                                   favourite.comment,
                                   favourite.title];
            
            const char *update_stmt = [updateSQL UTF8String];
            sqlite3_prepare_v2(favouriteDB, update_stmt, -1, &statement, NULL );
            sqlite3_bind_int(statement, 1, favourite.imageId);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success = true;
            }
            
        }
        else{
            
            NSLog(@"New data, Insert Please");
            NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO FAVOURITES(IMAGEURL,TITLE,COMMENT) VALUES(\"%@\",\"%@\",\"%@\")",[favourite.url absoluteString],favourite.title,favourite.comment];
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(favouriteDB, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success = true;
            }
        }

 /*
    // NSLog(@"1");
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO FAVOURITES(IMAGEURL,TITLE,COMMENT) VALUES(\"%@\",\"%@\",\"%@\")",[imageDetail.url absoluteString],self.favouriteTitle.text,self.comment.text];
    // NSLog(@"2");
    const char *update_stmt = [insertSQL UTF8String];
    // NSLog(@"3");
    sqlite3_prepare_v2(favouriteDB, update_stmt, -1, &statement, NULL);
    // NSLog(@"4");
    if (sqlite3_step(statement)==SQLITE_DONE) {
        NSLog(@"favourite saved successfully");
        
    }else{
        NSLog(@"Problems occured, please try again");
    }
    
    NSLog(@"exiting create");
  */
        sqlite3_finalize(statement);
        sqlite3_close(favouriteDB);        
    }
    return success;
}


- (NSMutableArray *) getFavourites{
   // NSLog(@"check 1");
   // ImageDetail *favourite = [[ImageDetail alloc]init];
     NSMutableArray *favouriteList = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &favouriteDB) == SQLITE_OK)
    {
       // NSLog(@"check  F 2");
        NSString *querySQL = [NSString stringWithFormat:@"SELECT ID,IMAGEURL,TITLE,COMMENT FROM FAVOURITES"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(favouriteDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
           // NSLog(@"check  F 3");
            while (sqlite3_step(statement) == SQLITE_ROW)
            {   ImageDetail *favourite = [[ImageDetail alloc]init];
                favourite.imageId = sqlite3_column_int(statement, 0);
             
                favourite.comment =[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                favourite.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                favourite.imageString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                [favouriteList addObject:favourite];
                
            }
            sqlite3_finalize(statement);
          
        }
        sqlite3_close(favouriteDB);
    }
    return favouriteList;
}//getFavourites



- (ImageDetail *) getFavourite:(NSInteger) imageId{
    ImageDetail *favourite = [[ImageDetail alloc]init];
    NSMutableArray *favouriteList = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;    
    if (sqlite3_open(dbpath, &favouriteDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT IMAGEURL,TITLE,COMMENT FROM FAVOURITES where id = %d",imageId];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(favouriteDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {                               favourite.imageId = sqlite3_column_int(statement, 0);
                favourite.comment =[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                favourite.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                favourite.imageString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                [favouriteList addObject:favourite];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(favouriteDB);
    }
    return favourite;
}//getFavourite

- (BOOL) deleteFavourite:(ImageDetail *)favourite{
    BOOL success = false;
    sqlite3_stmt *statement = NULL;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &favouriteDB) == SQLITE_OK)
    {
        if (favourite.imageId > 0) {
            NSLog(@"Exitsing data, Delete Please");
            NSString *deleteSQL = [NSString stringWithFormat:@"DELETE from FAVOURITES WHERE id = ?"];
            
            const char *delete_stmt = [deleteSQL UTF8String];
            sqlite3_prepare_v2(favouriteDB, delete_stmt, -1, &statement, NULL );
            sqlite3_bind_int(statement, 1, favourite.imageId);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success = true;
            }
            
        }
        else{
            NSLog(@"New data, Nothing to delete");
            success = true;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(favouriteDB);
        
    }
    
    return success;
}


@end
