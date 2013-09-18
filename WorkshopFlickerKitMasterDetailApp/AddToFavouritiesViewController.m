//
//  AddToFavouritiesViewController.m
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/10/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import "AddToFavouritiesViewController.h"
#import "ImageDetail.h"
#import "Toast+UIView.h"
@interface AddToFavouritiesViewController ()
- (void)configureView;
@end

@implementation AddToFavouritiesViewController
@synthesize imageDetail,favouriteDBUtil;
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // favouriteDBUtil = [[FavouriteDBUtil alloc]init];
       // [favouriteDBUtil initDatabase];
       
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    favouriteDBUtil = [[FavouriteDBUtil alloc]init];
    [favouriteDBUtil initDatabase];
    
	// Do any additional setup after loading the view.
    [self configureView];
   
    //[self createDB];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureView{
    if (self.detailItem) {
        imageDetail = (ImageDetail *)self.detailItem;
        
        self.favouriteTitle.text = imageDetail.title;
        
        //set image
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage* myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageDetail.url]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.favouriteImage setImage:myImage];
            });
        });
        
    }
}

- (IBAction)saveFavourite:(id)sender{
 
    /*
    const char *dbpath = [databasePath UTF8String];
    sqlite3_open(dbpath, &favouriteDB);
    NSLog(@"inside create");
    sqlite3_stmt *statement;
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
    
    NSLog(@"exiting create");*/


imageDetail.imageString = [imageDetail.url absoluteString];
imageDetail.title = self.favouriteTitle.text;
imageDetail.comment = self.comment.text;

if([favouriteDBUtil saveFavourite:imageDetail]){
    //NSLog(@"favourite saved successfully");
    [self.view makeToast:@"Favourite is saved successfully."
                duration:3.0
                position:@"center"
                   image:[UIImage imageNamed:@"tick2.JPG"]];
}else{
    NSLog(@"problems occured while saving favourite");
}

}

-(IBAction)cancel:(id)sender{
    
}

-(void)createDB{
    NSLog(@"inside createDB");
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
}//creates new database if database is not existing.

-(void)selectAllFavourites{
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"favourite.sqlite"]];
     const char *dbpath = [databasePath UTF8String];
      sqlite3_open(dbpath, &favouriteDB);
    
    sqlite3_stmt *statement;
    // NSLog(@"1");
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT IMAGEURL,TITLE,COMMENT FROM FAVOURITES"];
     const char  *query_stmt = [selectSQL UTF8String];
    
    sqlite3_prepare_v2(favouriteDB, query_stmt, -1, &statement, NULL);
    
    while (sqlite3_step(statement)) {
        NSString *url = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
        NSLog(@"image url:%@",url);
        NSString *title = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
        NSLog(@"image url:%@",title);
    }
    
    sqlite3_finalize(statement);
}



- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)backgroundTap:(id)sender{
    [self.favouriteTitle resignFirstResponder];
    [self.comment resignFirstResponder];
}
@end
