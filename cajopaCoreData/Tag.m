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
    
    NSError *fetchError = nil;
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:moc];
    [fr setEntity:entityDescription];
    
    NSMutableArray *newTags = [NSMutableArray new];
    
    for ( NSString *name in names ) {
        // Add a Tag to our Item
        
        // Need to ensure that we don't already have a
        // tag with that name.
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name == %@ )", name];
        [fr setPredicate:predicate];
        
        NSArray *tagsWithName = [moc executeFetchRequest:fr error:&fetchError];
        
        if (tagsWithName.count == 0) {
            // add a new tag with this name
            Tag *newTag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:moc];
            newTag.name = name;
            NSLog(@"tagsWithNames: %@", newTag.name);
            [newTags addObject:newTag];
        }
        else {
            // otherwise, use the Tag object returned by the fetch
            // TODO: we should probably add check to ensure that exactly
            // one tag was returned.
            [newTags addObject:tagsWithName[0]];
        }
    }
    
    return ( [NSSet setWithArray:newTags] );
    
}

@end
