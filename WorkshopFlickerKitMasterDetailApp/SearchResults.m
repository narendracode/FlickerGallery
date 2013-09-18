//
//  SearchResults.m
//  GoogleSearchJSON
//
//  Created by Ouh Eng Lieh on 5/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchResults.h"


@implementation SearchResults
@synthesize searchLinks, searchTitles, selectedLink;

- (id) init {
    self = [super init];

	self.searchLinks = [[NSMutableArray alloc] init];
	self.searchTitles = [[NSMutableArray alloc] init];
	self.selectedLink = @"www.google.com";
	return self;
}

@end
