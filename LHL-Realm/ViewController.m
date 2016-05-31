//
//  ViewController.m
//  LHL-Realm
//
//  Created by Asuka Nakagawa on 2016-05-30.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "ViewController.h"
#import "Room.h"
#import "FurnitureDetailedTableViewController.h"


@interface ViewController ()

// RLMResults is like array
//@property RLMResults<Furniture *> *furnitureArray;
@property RLMResults<Room *> *roomArray;


@property UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // to get URL
    NSLog(@"config is %@", [[RLMRealm defaultRealm] configuration]);
    
//    Room *living = [[Room alloc] init];
//    living.furnitureID = 1;
//    living.roomName = @"Living";
//    
//    
//    Room *dining = [[Room alloc] init];
//    dining.furnitureID = 2;
//    dining.roomName = @"Dining";
//
//    
//    // in Realm, create (Funiture *)table
//    Furniture *table = [[Furniture alloc] init];
//    
//    // set name for object which just created
//    table.name = @"coffee table";
//    
//    Furniture *chair = [[Furniture alloc] init];
//    chair.name = @"couch";
//    
//    // asking Realm to get all the listOfRooms
    self.roomArray = [Room allObjects];
//
//    
//    // asking Realm to get all the listOfFurnitures
//    self.furnitureArray = [Furniture allObjects];
////    rooms.count; // => 0 because no rooms have been added to the Realm yet
//    
//    // Persist(save) data easily
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        
//        [realm addObject:living];
//        [realm addObject:dining];
//        
//        [realm addObject:table];
//        [realm addObject:chair];
//    
//    }];
    
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

- (IBAction)roomButtonPressed:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Adding" message:@"Enter new room" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"SAVE" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
        // create empty Room object
        Room *newRoom = [[Room alloc] init];
        NSLog(@"_textField.text %@", _textField.text);
        
        newRoom.roomName = _textField.text;
        
        Furniture *table1 = [[Furniture alloc] init];
        Furniture *chair1 = [[Furniture alloc] init];
        table1.name = [NSString stringWithFormat:@"%@%@", _textField.text, @"'s table"];
        chair1.name = [NSString stringWithFormat:@"%@%@", _textField.text, @"'s chair"];
        
        
        
        
        // saving into the roomArray
//        self.roomArray = [Room allObjects];

        // Persist(save) data
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm addObject:newRoom];
            [newRoom.furnitures addObject:table1];
            [newRoom.furnitures addObject:chair1];
            
        }];
        // update array by quering realm
        // reloadData to display the array with newRoom
        self.roomArray = [Room allObjects];
//        self.furnitureArray = [Furniture allObjects];
        
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:save];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Add room";
        _textField = textField;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)furnitureButtonPressed:(UIBarButtonItem *)sender {
    
//    UIAlertController * alert1 = [UIAlertController alertControllerWithTitle:@"Adding" message:@"Enter new furniture" preferredStyle: UIAlertControllerStyleAlert];
//        [self presentViewController:alert1 animated:YES completion:nil];

}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    FurnitureDetailedTableViewController *dvc = segue.destinationViewController;
    
    // cell is sender
    UITableViewCell *cell = (UITableViewCell*) sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    
    // set specific cell has specific data
    Room *room = [self.roomArray objectAtIndex:indexPath.row];
    dvc.room = room;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
