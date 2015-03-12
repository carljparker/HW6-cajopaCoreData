//
//  ItemList.h
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/12/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ItemList : NSObject

// properties
//@property (readwrite, assign) BOOL duplicatesOK;
@property (readonly, assign) NSString * listTitle;

// methods
+ (instancetype) itemListWithTitle:(NSString *)title;

- (void) addItem:(Item *)item; // create and insert item if OK
//- (void) replaceItemWithTitle:(NSInteger) idx
//                     newTitle:(NSString *) title;
//- (void) removeItemWithTitle:(NSString *) title;
//- (BOOL) hasItemWithTitle:(NSString*)title; // check if any item contained already has same title

- (NSArray *) itemTitles;  // an array of all item titles (NSString*)
- (NSArray *) allItems;    // an array of all items
- (NSUInteger) itemCount; // number of items contained in list

@end
