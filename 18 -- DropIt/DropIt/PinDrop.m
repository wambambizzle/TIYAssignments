//
//  PinDrop.m
//  DropIt
//
//  Created by Jordan Anderson on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "PinDrop.h"

@interface PinDrop ()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation PinDrop


- (instancetype)initWithCoorindate:(CLLocationCoordinate2D)coordinate
{
    if (self)
    {
        self = [super init];
        _coordinate = coordinate;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return _coordinate; // if override a getter/setter must you "_" for instance variable
}

- (MKMapItem *)mapItem
{
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
//    mapItem.name = self.name;
    
    return mapItem;
}

//- (void)encodeWithCoder:(NSCoder *)aCoder //aka saving the data
//{
//
//}
//
//
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//   
//}





@end
