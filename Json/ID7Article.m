//
//  ID7Article.m
//  Json
//
//  Created by Soeren Kroell on 25.02.14.
//  Copyright (c) 2014 Soeren Kroell | iD.SEVEN. All rights reserved.
//

#import "ID7Article.h"

@implementation ID7Article


- (id) initWithName: (NSString*) inName andPrice: (NSString *)inPrice andId: (NSString*)__identity;{
    
    ID7Article *article = [[ID7Article alloc] init];
   
    article.name = inName;
    article.price = inPrice;
    article.__identity = __identity;
    
    return article;
}


@end
