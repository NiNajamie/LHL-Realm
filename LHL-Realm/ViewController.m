//
//  ViewController.m
//  LHL-Realm
//
//  Created by Asuka Nakagawa on 2016-05-30.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "ViewController.h"
#import "Room.h"


@interface ViewController ()

// RLMResults is like array
@property RLMResults<Furniture *> *furnitureArray;
@property RLMResults<Room *> *roomArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // to get URL
    NSLog(@"config is %@", [[RLMRealm defaultRealm] configuration]);
    
    Room *living = [[Room alloc] init];
    living.furnitureId = 1;
    living.roomName = @"Living";
    
    Room *dining = [[Room alloc] init];
    living.furnitureId = 2;
    dining.roomName = @"Dining";

    
    // in Realm, create (Funiture *)table
    Furniture *table = [[Furniture alloc] init];
    
    // set name for object which just created
    table.name = @"coffee table";
    
    Furniture *chair = [[Furniture alloc] init];
    chair.name = @"couch";
    
    // asking Realm to get all the listOfRooms
    self.roomArray = [Room allObjects];

    
    // asking Realm to get all the listOfFurnitures
    self.furnitureArray = [Furniture allObjects];
//    rooms.count; // => 0 because no rooms have been added to the Realm yet
    
    // Persist(save) data easily
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        
        [realm addObject:living];
        [realm addObject:dining];

        [realm addObject:table];
        [realm addObject:chair];
//        [realm addObject:dining];
    
    }];
//    rooms.count;
    
    

//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Adding" message:@"Enter new room" preferredStyle:UIAlertControllerStyleAlert];
//    [self presentViewController:alert animated:YES completion:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.furnitureArray count];
    return [self.roomArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
//    Furniture *furniture = self.furnitureArray[indexPath.row];
//    cell.textLabel.text = furniture.name;
    Room *room = self.roomArray[indexPath.row];
    cell.textLabel.text = room.roomName;
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
