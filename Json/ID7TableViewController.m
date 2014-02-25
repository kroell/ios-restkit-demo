//
//  ID7TableViewController.m
//  Json
//
//  Created by Soeren Kroell on 25.02.14.
//  Copyright (c) 2014 Soeren Kroell | iD.SEVEN. All rights reserved.
//

#import "ID7TableViewController.h"
#import "ID7Article.h"
#import <RestKit/RestKit.h>


//#define getDataURL @"http://www.conkave.com/iosdemos/json.php"
#define getDataURL @"http://dev.time2tri.de/api/users"


@interface ID7TableViewController ()

@end

@implementation ID7TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"JSON TEST";
    
    self.articleArray = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.articleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    ID7Article *article;
    
    article = [self.articleArray objectAtIndex:indexPath.row];
    cell.textLabel.text = article.name;
    cell.detailTextLabel.text = article.__identity;
    
    return cell;
}



- (IBAction)button:(id)sender {
    
    
    [[RKObjectManager sharedManager] getObject:nil path:@"/api/articles" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSLog(@"\n\nRESULT GET\n\n%@",mappingResult);
        ID7Article *article = [mappingResult firstObject];
        [self.articleArray addObject:article];
        NSLog(@"\nERSTER ARTIKEL %@\n", article.name);
        
        [self.tableView reloadData];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"\nERROR USERS\n");
    }];
}

- (IBAction)logoutTapped:(id)sender {
    
    [[RKObjectManager sharedManager] getObject:nil path:@"/logout" parameters:nil success:nil failure:nil];
    self.articleArray = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
}


@end
