//
//  FurnitureDetailedTableViewController.h
//  LHL-Realm
//
//  Created by Asuka Nakagawa on 2016-05-30.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "Room.h"

@interface FurnitureDetailedTableViewController : UITableViewController

@property (nonatomic) Room *room;

@end
