//
//  ItemList.m
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/12/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import "ItemList.h"
#import "Item.h"

@interface ItemList ()

@property (readwrite, assign) NSString * listTitle;
@property (readwrite) NSMutableArray * theList;

@end


@implementation ItemList

+(instancetype)itemListWithTitle:(NSString *)title;
{
    ItemList *object = [[self alloc] init];
    object.listTitle = title;
    object.theList = [NSMutableArray new];
    return object;
}

// create and insert item if OK
-(void) addItem:(NSString*) item {
    
    NSUInteger currentCount = [self.theList count];
        
    [self.theList addObject:item];
    
    // test
    NSUInteger newCount = [self.theList count];
    assert( newCount == currentCount + 1);
    
}

// an array of all item titles (NSString*)
-(NSArray*) itemTitles {
    
    NSMutableArray * titleArray = [NSMutableArray new];
    
    for (id item in self.theList) {
        [titleArray addObject:[item title]];
    }
    NSLog(@"%lu", (unsigned long)[titleArray count]);
    return [NSArray arrayWithArray:titleArray];
    
}


// an array of all items
-(NSArray*) allItems {
    
    return [NSArray arrayWithArray:self.theList];
    
}


// number of items contained in list
-(NSUInteger) itemCount {
    
    return [self.theList count];
}


@end
