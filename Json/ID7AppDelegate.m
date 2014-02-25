//
//  ID7AppDelegate.m
//  Json
//
//  Created by Soeren Kroell on 25.02.14.
//  Copyright (c) 2014 Soeren Kroell | iD.SEVEN. All rights reserved.
//

#import "ID7AppDelegate.h"
#import "ID7Article.h"
#import <RestKit/RestKit.h>


@implementation ID7AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Zeigt Netzwerk-Protokolle
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    //RKLogConfigureFromEnvironment();
    

    
    // ###### SETUP FOR ARTICLE ######## //
    
    
    // RESPONSE MAPPING
    RKObjectMapping* articleResponseMapping = [RKObjectMapping mappingForClass:[ID7Article class]]; // Shortcut for [RKObjectMapping mappingForClass:[NSMutableDictionary class] ]
    [articleResponseMapping addAttributeMappingsFromArray:@[ @"price", @"name", @"__identity"]];

    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    // RESPONSE  ESCRIPTOR
    RKResponseDescriptor *responseArticleDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleResponseMapping method:RKRequestMethodAny pathPattern:@"/api/articles" keyPath:@"data" statusCodes:statusCodes];
    
    // RESPONSE SINGLE DESCRIPTOR
    RKResponseDescriptor *responseArticleSingleDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleResponseMapping method:RKRequestMethodGET pathPattern:@"/api/articles/:__identity" keyPath:@"data" statusCodes:statusCodes];
    
    
    
    // REQUEST MAPPING
    RKObjectMapping* articleRequestMapping = [RKObjectMapping requestMapping ]; // Shortcut for [RKObjectMapping mappingForClass:[NSMutableDictionary class] ]
    [articleRequestMapping addAttributeMappingsFromArray:@[ @"name", @"price", @"__identity" ]];

    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:articleRequestMapping objectClass:[ID7Article class] rootKeyPath:@"article" method:RKRequestMethodAny];
    
    
    
    // MANAGER
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://local.time2tri.me"]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:responseArticleDescriptor];
    [manager addResponseDescriptor:responseArticleSingleDescriptor];
    //manager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    
    
    // NEW ARTICLE TO POST
    ID7Article* article = [ID7Article new];
    article.name = @"This is my new one!";
    article.price = @"17";
    
    
    // POST
//    [manager postObject:article path:@"/api/articles"
//             parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//                 
//                 NSLog(@"\nRESULT\n\n%@",mappingResult);
//                 ID7Article *article = [mappingResult firstObject];
//                 
//                 NSLog(@"Mapped the article: %@", article.__identity);
//                 
//             } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//                 NSLog(@"%@",error);
//             }];
    
    
    // DELETE
//    [manager deleteObject:article path:@"/api/articles/f2547f08-5e1f-8cce-0e24-af59ddb983a8" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        
//        NSLog(@"\nRESULT GET\n\n%@",mappingResult);
//        ID7Article *article = [mappingResult firstObject];
//        
//        NSLog(@"GET: %@", article.name);
//        
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];


    // GET SINGLE
//    [manager getObject:article path:@"/api/articles/761cad10-d58e-f48e-8376-75b729f49582" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        
//        NSLog(@"\nRESULT GET\n\n%@",mappingResult);
//        ID7Article *article = [mappingResult firstObject];
//        
//        NSLog(@"GET: %@", article.name);
//        
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
    
    // PUT
//    ID7Article* article2 = [ID7Article new];
//    article2.name = @"I have a new name!";
//    article2.price = @"25.45";
//    article2.__identity = @"761cad10-d58e-f48e-8376-75b729f49582";
//    
//    NSDictionary *param = @{ @"price": article2.price, @"name": article2.name};
//    
//    [manager putObject:article2 path:@"/api/articles" parameters:param success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        
//        NSLog(@"\nRESULT GET\n\n%@",mappingResult);
//        ID7Article *article = [mappingResult firstObject];
//        
//        NSLog(@"GET: %@", article.name);
//        
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        NSLog(@"EERROROOOR");
//    }];
    
    //[manager.HTTPClient setAuthorizationHeaderWithUsername:@"syren@time2tri.me" password:@"syren"];
    NSDictionary *param = @{ @"__authentication[TYPO3][Flow][Security][Authentication][Token][UsernamePassword][username]": @"marty@time2tri.me",
                             @"__authentication[TYPO3][Flow][Security][Authentication][Token][UsernamePassword][password]": @"marty"
                             };
    
    [manager postObject:nil path:@"/login/authenticate.json" parameters:param success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSLog(@"\nRESULT GET\n\n%@",mappingResult);
        
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"\nEERROROOOR");
    }];
    
    
    
    
//    [manager getObject:nil path:@"/api/currentuser" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//
//        NSLog(@"\n\nRESULT USERS GET\n\n%@",mappingResult);
//
//  
//     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//          NSLog(@"\nERROR USERS\n");
//      }];

   
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
