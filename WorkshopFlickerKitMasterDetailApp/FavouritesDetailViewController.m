//
//  FavouritesDetailViewController.m
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/11/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import "FavouritesDetailViewController.h"
#import "SWRevealViewController.h"
#import "Toast+UIView.h"

@interface FavouritesDetailViewController ()

@end

@implementation FavouritesDetailViewController
@synthesize imageDetail,favouriteDBUtil;


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        //self.detailDescriptionLabel.text = [self.detailItem description];
        imageDetail = (ImageDetail *)self.detailItem;
        
        self.favouriteTitle.text = imageDetail.title;
        self.favouriteComment.text = imageDetail.comment;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage* myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageDetail.url]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.favouriteImage setImage:myImage];
            });
        });
    }
}//configureView

- (void)viewDidLoad
{
    [super viewDidLoad];
    favouriteDBUtil = [[FavouriteDBUtil alloc]init];
    [favouriteDBUtil initDatabase];
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.sidebarButton;
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Prepare for segue is executed in Detail view controller");
    //showFavourite
    if ([[segue identifier] isEqualToString:@"showFavourite"]) {
        [[segue destinationViewController] setDetailItem:imageDetail];
        NSLog(@"test image title: %@",imageDetail.title);
        
        [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromRight
                               forView:[[segue destinationViewController] view] cache:YES];
        
    }
}
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FavouriteCell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[FavouriteCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    
   // NSUInteger sectionIndex = [indexPath section];
  //  NSUInteger rowIndex = [indexPath row];
    
    //cell.label.text = [row objectForKey:@"label"];
    //cell.textField.text = [[self.hero valueForKey:[row objectForKey:@"key"]] description];
    
    return cell;
}

-(IBAction)saveFavourite:(id)sender{
    imageDetail.comment =[[self favouriteComment]text];
    imageDetail.title = self.favouriteTitle.text;
    [favouriteDBUtil saveFavourite:imageDetail];
    //NSLog(@"ID: %d, comment:%@, title:%@",imageDetail.imageId,imageDetail.comment,imageDetail.title);
    
    [self.view makeToast:@"Favourite is saved successfully."
                duration:3.0
                position:@"center"
                   image:[UIImage imageNamed:@"tick2.JPG"]];
}
- (void)save
{
    [self setEditing:NO animated:YES];
    
    //iterate over each cell to save changes..
    //for (FavouriteCell *cell in [self.tableView visibleCells])
       // [self.hero setValue:[cell value] forKey:[cell key]];
    
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

@end
