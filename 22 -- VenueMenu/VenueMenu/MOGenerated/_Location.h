// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Location.h instead.

#import <CoreData/CoreData.h>

extern const struct LocationAttributes {
	__unsafe_unretained NSString *lat;
	__unsafe_unretained NSString *lng;
	__unsafe_unretained NSString *streetAddress;
} LocationAttributes;

extern const struct LocationRelationships {
	__unsafe_unretained NSString *venue;
} LocationRelationships;

@class Venue;

@interface LocationID : NSManagedObjectID {}
@end

@interface _Location : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LocationID* objectID;

@property (nonatomic, strong) NSNumber* lat;

@property (atomic) double latValue;
- (double)latValue;
- (void)setLatValue:(double)value_;

//- (BOOL)validateLat:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* lng;

@property (atomic) double lngValue;
- (double)lngValue;
- (void)setLngValue:(double)value_;

//- (BOOL)validateLng:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* streetAddress;

//- (BOOL)validateStreetAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Venue *venue;

//- (BOOL)validateVenue:(id*)value_ error:(NSError**)error_;

@end

@interface _Location (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveLat;
- (void)setPrimitiveLat:(NSNumber*)value;

- (double)primitiveLatValue;
- (void)setPrimitiveLatValue:(double)value_;

- (NSNumber*)primitiveLng;
- (void)setPrimitiveLng:(NSNumber*)value;

- (double)primitiveLngValue;
- (void)setPrimitiveLngValue:(double)value_;

- (NSString*)primitiveStreetAddress;
- (void)setPrimitiveStreetAddress:(NSString*)value;

- (Venue*)primitiveVenue;
- (void)setPrimitiveVenue:(Venue*)value;

@end
