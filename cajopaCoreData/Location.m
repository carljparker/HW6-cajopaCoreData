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
    // Add a Location
    Location *location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:moc];
    location.latitude  = Lat;
    location.longitude = Long;
    
    return (location);
    
}

+(instancetype)locationWithHBO:(NSManagedObjectContext *)moc;
{
    return( [Location locationWithLatitude:47.616645 Longitude:-122.327873 managedObjectContext:moc] );
}

@end
