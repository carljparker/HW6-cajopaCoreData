//
//  Location.h
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/13/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Location : NSManagedObject

@property (nonatomic) double latitude;    // HBO Office:   47.616645
@property (nonatomic) double longitude;   // HBO Office: -122.327873

+(instancetype)locationWithLatitude:(double)Lat    // Make Lat and Long initial cap so that
                          Longitude:(double)Long   // Long doesn't conflict with the type long
        managedObjectContext:(NSManagedObjectContext *)moc;

+(instancetype)locationWithHBO:(NSManagedObjectContext *)moc;

@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addItemsObject:(NSManagedObject *)value;
- (void)removeItemsObject:(NSManagedObject *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end

