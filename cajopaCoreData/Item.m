//
//  Item.m
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/6/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

@import CoreData;
#import "Tag.h"
#import "Item.h"


@implementation Item

@dynamic detail;
@dynamic price;
@dynamic title;
@dynamic uuid;
@dynamic images;
@dynamic tags;
@dynamic location;

+(instancetype)itemWithTitle:(NSString *)title
        managedObjectContext: (NSManagedObjectContext *) moc
{
    
    NSError *fetchError = nil;
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:moc];
    [fr setEntity:entityDescription];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title = %@ )", title];
    [fr setPredicate:predicate];
    
    NSArray *itemsWithTitle = [moc executeFetchRequest:fr error:&fetchError];
 
    if (itemsWithTitle.count == 0) {
    
        Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:moc];
        item.title = title;
        return item;
    }
    else {
        // return the item from the fetch
        return itemsWithTitle[0];
    }
}

@end
