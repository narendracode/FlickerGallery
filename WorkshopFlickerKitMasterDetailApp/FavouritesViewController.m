//
//  FavouritesViewController.m
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/10/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import "FavouritesViewController.h"
#import "SWRevealViewController.h"
#import "FavouritesDetailViewController.h"
@interface FavouritesViewController ()

@end

@implementation FavouritesViewController
@synthesize favouriteDBUtil,favouritiesList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //  favouriteDBUtil = [[FavouriteDBUtil alloc]init];
        //[favouriteDBUtil initDatabase];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    favouriteDBUtil = [[FavouriteDBUtil alloc]init];
    [favouriteDBUtil initDatabase];
    //
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    self.title= @"Favourites";
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   // [self selectAllFavourites];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    favouritiesList = [self.favouriteDBUtil getFavourites] ;
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [favouritiesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];    
    UILabel *labelTitle = (UILabel *)[cell viewWithTag:100];
    //labelTitle.text = [object title];
    labelTitle.text = [[favouritiesList objectAtIndex:indexPath.row] title];  
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{        
        UIImage *myImage ;
       NSURL *url = [NSURL URLWithString:[[favouritiesList objectAtIndex:indexPath.row] imageString]];
       
        myImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
           // [self.spinner stopAnimating];
            [imageView setImage:myImage];            
        });   
    });
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    
    NSLog(@"inside Can edit Row At index path");
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ImageDetail *im = [favouritiesList objectAtIndex:indexPath.row];
        [favouritiesList removeObjectAtIndex:indexPath.row];
        [favouriteDBUtil deleteFavourite:im];
        
        NSLog(@"Count %d:",[favouritiesList count]);
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"Object deleted");
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        NSLog(@"Object editing style insert");
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ImageDetail *object = [[ImageDetail alloc]init];       
       object.url = [NSURL URLWithString:[[favouritiesList objectAtIndex:indexPath.row] imageString]];
        object.comment = [[favouritiesList objectAtIndex:indexPath.row] comment];
        object.title = [[favouritiesList objectAtIndex:indexPath.row] title];
        object.imageId = [[favouritiesList objectAtIndex:indexPath.row] imageId];
        object.imageString = [[favouritiesList objectAtIndex:indexPath.row] imageString];
        [[segue destinationViewController] setDetailItem:object];

    }
}


@end
