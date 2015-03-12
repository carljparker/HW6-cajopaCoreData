//
//  ViewController.h
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 2/26/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ConfigurableCoreDataStack.h"

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, readonly) NSManagedObjectContext *moc;

@property (weak) IBOutlet NSTableView *itemListTable;

@end

