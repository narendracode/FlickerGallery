//
//  DetailViewController.m
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/5/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import "DetailViewController.h"
#import "ImageDetail.h"
#import <Social/Social.h>
#import "FlickrKit.h"
@interface DetailViewController ()
- (void)configureView;

@end

@implementation DetailViewController
@synthesize titleLabel,detailImage,imageDetail;
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
        
        self.titleLabel.text = imageDetail.title;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage* myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageDetail.url]];
       
            dispatch_async(dispatch_get_main_queue(), ^{
            [self.detailImage setImage:myImage];
            });
        });
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareFacebook:(id)sender {
 /*   if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"Cancelled");
            } else
            {
                NSLog(@"Done");
            }
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        [controller setInitialText:imageDetail.title];
        [controller addURL:[NSURL URLWithString:@"http://www.iss.nus.edu.sg"]];
        [controller addImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:imageDetail.url]]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }*/
    
    
   // UIImagePickerControllerSourceType   sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
   // UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  //  picker.delegate = self;
   // picker.allowsEditing = YES;
   // picker.sourceType = sourceType;
   // [self presentViewController:picker animated:YES completion:nil];
    
    
    [self showActivityViewController];
    //displays the activitycontroller....
    
}//shareFacebook





- (IBAction)shareTwitter:(id)sender {
    
}


- (void)showActivityViewController
{
    NSString *message = NSLocalizedString(@"I took a picture on my iPhone",
                                          @"I took a picture on my iPhone");
    NSArray *activityItems = @[ message, [UIImage imageWithData:[NSData dataWithContentsOfURL:imageDetail.url]] ];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

#pragma mark - UIImagePickerController Delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //self.image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(showActivityViewController) withObject:nil afterDelay:0.5];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

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



@end
