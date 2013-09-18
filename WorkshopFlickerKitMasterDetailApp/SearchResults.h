//
//  SearchResults.h
//  GoogleSearchJSON
//
//  Created by Ouh Eng Lieh on 5/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchResults : NSObject {
    NSMutableArray *searchLinks;
    NSMutableArray *searchTitles;
	NSString *selectedLink;
}
@property(strong, nonatomic) NSMutableArray *searchLinks;
@property(strong, nonatomic) NSMutableArray *searchTitles;
@property(strong, nonatomic) NSString *selectedLink;

@end
