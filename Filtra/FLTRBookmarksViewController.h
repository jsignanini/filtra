//
//  FLTRBookmarksViewController.h
//  Filtra
//
//  Created by José Signanini on 7/30/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLTRBookmarksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *bookmarks;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

- (IBAction)clickEdit:(id)sender;

@end
