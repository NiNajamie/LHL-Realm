//
//  Furniture.h
//  LHL-Realm
//
//  Created by Asuka Nakagawa on 2016-05-30.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <Realm/Realm.h>
#import "Room.h"

RLM_ARRAY_TYPE(Room)
@interface Furniture : RLMObject
@property NSString *table;
@property NSString *couch;
@property RLMArray<Room *><Room> *rooms;
@end
