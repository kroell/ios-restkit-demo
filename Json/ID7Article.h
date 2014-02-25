//
//  ID7Article.h
//  Json
//
//  Created by Soeren Kroell on 25.02.14.
//  Copyright (c) 2014 Soeren Kroell | iD.SEVEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ID7Article : NSObject

@property (copy,nonatomic) NSString *__identity;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *price;

- (id) initWithName: (NSString*) inName andPrice: (NSString *)inPrice andId: (NSString*)__identity;

@end
