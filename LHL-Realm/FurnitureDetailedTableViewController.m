//
//  FurnitureDetailedTableViewController.m
//  LHL-Realm
//
//  Created by Asuka Nakagawa on 2016-05-30.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "FurnitureDetailedTableViewController.h"
#import "Room.h"
#import "ViewController.h"

@interface FurnitureDetailedTableViewController ()
//@property RLMResults<Furniture *> *detailFurnitureArray;


@property UITextField *textField1;


@end

@implementation FurnitureDetailedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.detailFurnitureArray = [Furniture allObjects];
//    NSLog(@"%@", _room);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.room.furnitures count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    
        // room has a arrayOfFurnitures, display them
        Furniture *furniture = self.room.furnitures[indexPath.row];
        cell.textLabel.text = furniture.name;

    return cell;
}

- (IBAction)furniturePressed:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Adding" message:@"Enter new furniture" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"SAVE" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // create empty newFurniture object
        Furniture *newFurniture = [[Furniture alloc] init];
        NSLog(@"_textField.text %@", _textField1.text);
        
        newFurniture.name = _textField1.text;
        
        // Persist(save) data
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [self.room.furnitures addObject:newFurniture];
        }];
        // update array by quering realm
        // reloadData to display the array with newRoom
//        self.detailFurnitureArray = [Furniture allObjects];
        
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:save];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Add furniture";
        // get userinput to set new furniture
        _textField1 = textField;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];

    
}



/*
 #pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/



@end
