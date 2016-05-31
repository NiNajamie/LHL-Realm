//
//  Room.h
//  LHL-Realm
//
//  Created by Asuka Nakagawa on 2016-05-30.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <Realm/Realm.h>


@interface Furniture : RLMObject

@property (nonatomic) NSString *name;


@end


RLM_ARRAY_TYPE(Furniture)

@interface Room : RLMObject

@property (nonatomic) NSString *roomName;

@property RLMArray<Furniture *><Furniture> *furnitures;
@property RLMArray<Furniture *><Furniture> *livingFurnitureArray;
@property NSInteger furnitureID;

@end




