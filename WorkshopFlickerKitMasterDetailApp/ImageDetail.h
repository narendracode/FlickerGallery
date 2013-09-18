//
//  ImageDetail.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/6/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDetail : NSObject
@property NSURL *url;
@property NSString *farm;
//@property NSString *imageId;
@property NSString *isfamily;
@property NSString *isfriend;
@property NSString *ispublic;
@property NSString *server;
@property NSString *owner;
@property NSString *secret;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *comment;
@property (nonatomic,strong)NSString *imageString;
@property (nonatomic) NSInteger imageId;
@end
