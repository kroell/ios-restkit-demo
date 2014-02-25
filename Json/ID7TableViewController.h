//
//  ID7TableViewController.h
//  Json
//
//  Created by Soeren Kroell on 25.02.14.
//  Copyright (c) 2014 Soeren Kroell | iD.SEVEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ID7TableViewController : UITableViewController


@property (nonatomic, strong) NSMutableArray *articleArray;


- (IBAction)button:(id)sender;
- (IBAction)logoutTapped:(id)sender;


@end
