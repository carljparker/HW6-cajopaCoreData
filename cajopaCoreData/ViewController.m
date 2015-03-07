//
//  ViewController.m
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 2/26/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import "ViewController.h"
#import "ConfigurableCoreDataStack.h"
#import "Item.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
        
    CoreDataStackConfiguration *config = [CoreDataStackConfiguration new];
    config.storeType = NSSQLiteStoreType;
    config.modelName = @"cajopaCoreData";
    config.appIdentifier = @"com.hbo.parker.carl.inventory";  // or whatever this should be
    config.dataFileNameWithExtension = @"InventoryDB.sqlite";
    config.searchPathDirectory = NSApplicationSupportDirectory;
    
    ConfigurableCoreDataStack *stack = [[ConfigurableCoreDataStack alloc] initWithConfiguration:config];
    
    NSManagedObjectContext *moc = stack.managedObjectContext;
    
    Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:moc];
    
    item.title = @"cool toy";
    
    NSError *saveError = nil;
    
    BOOL success = [moc save:&saveError];
    
    if (!success){
        [[NSApplication sharedApplication] presentError:saveError];
    }
    
    NSLog(@"%@", item);
    
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    NSError *fetchError = nil;
    
    NSArray *allitems = [moc executeFetchRequest:fr error:&fetchError];
    
    NSLog( @"%@", allitems);
    
    for (Item *singleItem in allitems) {
        [moc deleteObject:singleItem];
    }
    
    [moc save:nil];
    
    [stack killCoreDataStack];

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
