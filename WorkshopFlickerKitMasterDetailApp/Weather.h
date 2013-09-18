//
//  Weather.h
//  WorkshopFlickerKitMasterDetailApp
//
//  Created by Narendra Soni on 8/12/13.
//  Copyright (c) 2013 National University Of Singapore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
@property (nonatomic,strong)NSString *cloudcover;
@property (nonatomic,strong)NSString *humidity;
@property (nonatomic,strong)NSString *precipMM;
@property (nonatomic,strong)NSString *pressure;
@property (nonatomic,strong)NSString *temp_C;
@property (nonatomic,strong)NSString *temp_F;
@property (nonatomic,strong)NSString *weatherDesc;
@property (nonatomic,strong)NSString *iconUrl;
@property (nonatomic,strong)NSString *winddirDegree;
@property (nonatomic,strong)NSString *windspeedKmph;
@property (nonatomic,strong)NSString *address;
@end
