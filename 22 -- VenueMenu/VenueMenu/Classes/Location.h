#import "_Location.h"
@import MapKit;

@interface Location : _Location <MKAnnotation>


@property (strong, nonatomic) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinate;

// Custom logic goes here.
@end
