//
//  Tag.m
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/9/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import "Tag.h"
#import "Item.h"


@implementation Tag

@dynamic name;
@dynamic item;

+(NSSet *) tagsWithNames:(NSArray *) names
    managedObjectContext:(NSManagedObjectContext *)moc
{
    NSMutableArray *tags;
    
    for ( NSString *name in names ) {
        // Add a Tag to our Item
        Tag *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:moc];
        tag.name = name;
        [tags addObject:tag];
    }
    
    return ( [NSSet setWithArray:tags] );
    
}

@end
