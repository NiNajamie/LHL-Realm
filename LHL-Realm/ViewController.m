//
//  ViewController.m
//  LHL-Realm
//
//  Created by Asuka Nakagawa on 2016-05-30.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "ViewController.h"
#import "Room.h"
#import "Furniture.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Room *room1 = [[Room alloc] init];
    room1.name = @"living";

    
    Furniture *furniture = [[Furniture alloc] init];
    furniture.table = @"table";
    furniture.couch = @"couch";
    
    // Query Realm for all rooms
    RLMResults<Room *> *rooms = [Room allObjects];
    rooms.count; // => 0 because no rooms have been added to the Realm yet
    
    // Query(save) data easily
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:room1];
    }];
    rooms.count;
    
    NSLog(@"%@", rooms);
    
    // Query and update the result in another thread
    dispatch_async(dispatch_queue_create("background", 0), ^{
        Room *theRoom = [[Room objectsWhere:@"age == 1"] firstObject];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        theRoom.name = @"";
        [realm commitWriteTransaction];
    });


//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Adding" message:@"Enter new room" preferredStyle:UIAlertControllerStyleAlert];
//    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
