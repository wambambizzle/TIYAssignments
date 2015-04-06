#import "Location.h"
#import "Venue.h"

@interface Location ()

// Private interface goes here.

@end

@implementation Location

// Custom logic goes here.

- (void)venueCoordinate
{
    self.coordinate = CLLocationCoordinate2DMake(self.latValue, self.lngValue);
}

- (NSString *)title
{
    return self.venue.name;
}

@end
