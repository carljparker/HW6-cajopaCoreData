//
//  Tag.h
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/9/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *item;

+(NSSet *) tagsWithNames:(NSArray *) names
    managedObjectContext:(NSManagedObjectContext *)moc;

@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addItemObject:(Item *)value;
- (void)removeItemObject:(Item *)value;
- (void)addItem:(NSSet *)values;
- (void)removeItem:(NSSet *)values;

@end
