// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.h instead.

#import <CoreData/CoreData.h>

extern const struct VenueAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *icon;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *phone;
	__unsafe_unretained NSString *postalCode;
	__unsafe_unretained NSString *state;
	__unsafe_unretained NSString *streeAddress;
	__unsafe_unretained NSString *userRating;
} VenueAttributes;

extern const struct VenueRelationships {
	__unsafe_unretained NSString *location;
} VenueRelationships;

@class Location;

@interface VenueID : NSManagedObjectID {}
@end

@interface _Venue : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) VenueID* objectID;

@property (nonatomic, strong) NSString* category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* city;

//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSData* icon;

//- (BOOL)validateIcon:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* phone;

//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* postalCode;

@property (atomic) int16_t postalCodeValue;
- (int16_t)postalCodeValue;
- (void)setPostalCodeValue:(int16_t)value_;

//- (BOOL)validatePostalCode:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* state;

//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* streeAddress;

//- (BOOL)validateStreeAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* userRating;

@property (atomic) int16_t userRatingValue;
- (int16_t)userRatingValue;
- (void)setUserRatingValue:(int16_t)value_;

//- (BOOL)validateUserRating:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Location *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@end

@interface _Venue (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;

- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;

- (NSData*)primitiveIcon;
- (void)setPrimitiveIcon:(NSData*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitivePhone;
- (void)setPrimitivePhone:(NSString*)value;

- (NSNumber*)primitivePostalCode;
- (void)setPrimitivePostalCode:(NSNumber*)value;

- (int16_t)primitivePostalCodeValue;
- (void)setPrimitivePostalCodeValue:(int16_t)value_;

- (NSString*)primitiveState;
- (void)setPrimitiveState:(NSString*)value;

- (NSString*)primitiveStreeAddress;
- (void)setPrimitiveStreeAddress:(NSString*)value;

- (NSNumber*)primitiveUserRating;
- (void)setPrimitiveUserRating:(NSNumber*)value;

- (int16_t)primitiveUserRatingValue;
- (void)setPrimitiveUserRatingValue:(int16_t)value_;

- (Location*)primitiveLocation;
- (void)setPrimitiveLocation:(Location*)value;

@end
