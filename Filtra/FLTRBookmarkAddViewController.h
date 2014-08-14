//
//  FLTRBookmarkAddViewController.h
//  Filtra
//
//  Created by José Signanini on 8/13/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLTRBookmarkAddViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *title;

@end
