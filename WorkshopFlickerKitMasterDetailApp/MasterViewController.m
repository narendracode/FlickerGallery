//
//  MasterViewController.m
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/5/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import "MasterViewController.h"
#import "FlickrKit.h"
#import "DetailViewController.h"
#import "ImageDetail.h"
#import <AVFoundation/AVFoundation.h>
#import "SWRevealViewController.h"
#import <UIKit/UIKit.h>
@interface MasterViewController () {
    NSMutableArray *_photoObjects;
    //SWRevealViewController *revealViewController ;
    NSMutableArray *photosCollection;
    NSString *apikey ;
    NSString *secret ;
}
@end
#define kNumberOfItemsToAdd 8
@implementation MasterViewController
@synthesize fm,player,timeObserver,masterView;

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (id)init
{
    self = [super init];
    if (self) {
        numberOfItemsToDisplay = kNumberOfItemsToAdd; 
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
   [self.spinner startAnimating];
    photosCollection = [[NSMutableArray alloc]init];
      
    [self searchPhotos:@"singapore"];
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    //_sidebarButton.target = self.revealViewController;
    //_sidebarButton.action = @selector(revealToggle:);
    // Set the gesture
   // NSLog(@"view...####### %@",self.navigationController.revealViewController);
  //[self.tableView addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    

    
   // UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
}


///////
-(void) viewDidAppear:(BOOL)animated{
   // [self.masterView addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}
//


-(void)searchPhotos:(NSString* )searchText{
    apikey = @"2e6bb6e6e3dc4db067d4ab8c5bcaeb76";
    secret = @"3968857e6bcaa558";
    
    //revealViewController = [[SWRevealViewController alloc]init];
    
	// Do any additional setup after loading the view, typically from a nib.
    //loading photo
    _photoObjects = [[NSMutableArray alloc]init];
    //loadiing photo
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:apikey sharedSecret:secret];
    FKFlickrPhotosSearch *search = [[FKFlickrPhotosSearch alloc] init];
	//search.text = @"singapore";
    search.text = searchText;
    [[FlickrKit sharedFlickrKit] call:search completion:^(NSDictionary *response, NSError *error) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // dispatch_async(dispatch_get_main_queue(), ^{
            if (response) {
				for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                    [ photosCollection addObject:photoData];
                    //  counter++;
                    //if (counter>13) {
                    //  break;
                    // }
				}
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
			} else {
                NSLog(@"No photos found");
			}
		});
	}];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
  /*  if (numberOfItemsToDisplay == [photosCollection count]) {
        return 1;
    }
    return 2;*/
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [photosCollection count];
  
  /*  if (section == 0) {
        return numberOfItemsToDisplay;
    } else {
        return 1;
    }*/

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
   // if (!cell) {
     //   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    //}
    
   // if (indexPath.section == 0) {
        //NSLog(@"check point 1");
    UILabel *labelTitle = (UILabel *)[cell viewWithTag:100];
    //labelTitle.text = [object title];
    labelTitle.text = [[photosCollection objectAtIndex:indexPath.row]objectForKey:@"title"];
 
   
  
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     UIImage *myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:[photosCollection objectAtIndex:indexPath.row]]]];
      dispatch_async(dispatch_get_main_queue(), ^{
       [self.spinner stopAnimating];   
    [imageView setImage:myImage];
          
     });   
    });
   
  /*  }else{
         NSLog(@"check point 2");
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Next %d items", @"The text to display to load more content"), kNumberOfItemsToAdd];
        //cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.textColor = [UIColor colorWithRed:0.196f green:0.3098f blue:0.52f alpha:1.f];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.f];
    }
    */
    
    return cell;
}


///////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSUInteger i, totalNumberOfItems = [photosCollection count];
        NSUInteger newNumberOfItemsToDisplay = MIN(totalNumberOfItems, numberOfItemsToDisplay + kNumberOfItemsToAdd);
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        
        for (i=numberOfItemsToDisplay; i<newNumberOfItemsToDisplay; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        numberOfItemsToDisplay = newNumberOfItemsToDisplay;
        
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        if (numberOfItemsToDisplay == totalNumberOfItems) {
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
        }
        [tableView endUpdates];
        
        // Scroll the cell to the top of the table
        
        NSIndexPath *scrollPointIndexPath;
        
        if (newNumberOfItemsToDisplay < totalNumberOfItems) {
            scrollPointIndexPath = indexPath;
        } else {
            scrollPointIndexPath = [NSIndexPath indexPathForRow:totalNumberOfItems-1 inSection:0];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 200000000), dispatch_get_main_queue(), ^(void){
            [tableView scrollToRowAtIndexPath:scrollPointIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        });
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
}
/////


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"the text in search bar is %@",self.searchBar.text);
    [photosCollection removeAllObjects];
    [self searchPhotos:self.searchBar.text];
    [self.searchBar resignFirstResponder];
     //[self.tableView reloadData];
     NSLog(@"the text in search bar exit");
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ImageDetail *object = [[ImageDetail alloc]init];
        object.url = [[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photosCollection[indexPath.row]];
        object.title = [photosCollection[indexPath.row] valueForKey:@"title" ];
        [[segue destinationViewController] setDetailItem:object];
        [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromRight
                               forView:[[segue destinationViewController] view] cache:YES];
        [UIView commitAnimations];
    }
}

@end
