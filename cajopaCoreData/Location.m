//
//  Location.m
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/13/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import "Location.h"

@implementation Location

@dynamic latitude;
@dynamic longitude;


+(instancetype)locationWithLatitude:(double)Lat    // Make Lat and Long initial cap so that
                          Longitude:(double)Long   // Long doesn't conflict with the type long
               managedObjectContext:(NSManagedObjectContext *)moc
{
    
    NSError *fetchError = nil;
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:moc];
    [fr setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"( ( latitude == %f ) && ( longitude == %f ) )", Lat, Long];
    [fr setPredicate:predicate];
    
    NSArray *locationsWithLatLong = [moc executeFetchRequest:fr error:&fetchError];
    
    if (locationsWithLatLong.count == 0) {

        // Add a Location
        Location *location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:moc];
        location.latitude  = Lat;
        location.longitude = Long;
        return (location);
    }
    else {
        return (locationsWithLatLong[0]);
    }
    
}

+(instancetype)locationWithHBO:(NSManagedObjectContext *)moc;
{
    return( [Location locationWithLatitude:47.616645 Longitude:-122.327873 managedObjectContext:moc] );
}

@end
