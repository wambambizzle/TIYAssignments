//
//  SearchResultsVenue.h
//  VenueMenu
//
//  Created by Jordan Anderson on 4/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultsVenue : NSObject

@property(strong, nonatomic) NSString *venueName;
@property(strong, nonatomic) NSString *venueAddress;
@property(strong, nonatomic) NSString *venueCity;
@property(strong, nonatomic) NSString *state;
@property (nonatomic) double lat;
@property (nonatomic) double lng;



@end
