//
//  PropertiesVC.h
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/15/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

@import CoreData;

#import <Cocoa/Cocoa.h>
#import "Item.h"
#import "Tag.h"
#import "Location.h"

@interface PropertiesVC : NSViewController <NSTextFieldDelegate, NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tagListTable;

@property (weak) IBOutlet NSTextField *itemTitleText;

@property (weak) IBOutlet NSTextField *tagNameText;

@property (weak) IBOutlet NSTextField *latText;

@property (weak) IBOutlet NSTextField *longText;

@property (weak) IBOutlet NSButton *updateLatLongBtn;

@property (weak) IBOutlet NSButton *showLocationBtn;

@property (nonatomic, readonly) NSArray * allTags;

@property (nonatomic, readwrite) Item *displayedItem;

@end
