//
//  Item.h
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/6/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Location.h"


@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) NSSet *tags;
@property (nonatomic, retain) Location *location;

// methods (additional)
+(instancetype)itemWithTitle:(NSString *)title
        managedObjectContext:(NSManagedObjectContext *)moc;

@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addImagesObject:(NSManagedObject *)value;
- (void)removeImagesObject:(NSManagedObject *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addTagsObject:(NSManagedObject *)value;
- (void)removeTagsObject:(NSManagedObject *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
