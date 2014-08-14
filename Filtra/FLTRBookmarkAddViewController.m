//
//  FLTRBookmarkAddViewController.m
//  Filtra
//
//  Created by José Signanini on 8/13/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import "FLTRBookmarkAddViewController.h"
#import "FLTRBookmarksCollection.h"
#import "FLTRBookmarkAddCell.h"

@interface FLTRBookmarkAddViewController ()

@end

@implementation FLTRBookmarkAddViewController

@synthesize tableView, url, title;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    long section = [indexPath section];
    if (section == 0) {
        return 88;
    } else {
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLTRBookmarkAddCell *cell;
    long section = [indexPath section];
    if (section == 0) {
        cell = [atableView dequeueReusableCellWithIdentifier:@"Bookmark Info" forIndexPath:indexPath];
        [cell.titleTextField setDelegate: self];
        [cell.titleTextField becomeFirstResponder];
        [cell.titleTextField setText: self.title];
        [cell.urlLabel setText: self.url];
    } else if (section == 1) {
        cell = [atableView dequeueReusableCellWithIdentifier:@"Bookmark Location" forIndexPath:indexPath];
    }
    
    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView setDelegate: self];
    [self.tableView setDataSource: self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBookmark:(id)sender
{
    [FLTRBookmarksCollection addBookmarkWithUrl: self.url title: self.title];
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.title = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
