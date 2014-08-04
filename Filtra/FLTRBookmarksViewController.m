//
//  FLTRBookmarksViewController.m
//  Filtra
//
//  Created by José Signanini on 7/30/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import "FLTRBookmarksViewController.h"
#import "FLTRBookmarkCell.h"
#import "FLTRBookmarksCollection.h"
#import "FLTRBookmark.h"
#import "FLTRTabsCollection.h"

@interface FLTRBookmarksViewController ()

@end

@implementation FLTRBookmarksViewController

@synthesize tableView, bookmarks;

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLTRBookmark *bookmark = [FLTRBookmarksCollection getBookmarks][[indexPath row]];
    [FLTRTabsCollection createTab: bookmark.url.absoluteString];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[FLTRBookmarksCollection getBookmarks] count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    long row = [indexPath row];
    FLTRBookmark *bookmark = [FLTRBookmarksCollection getBookmarks][row];
    FLTRBookmarkCell *bookmarkCell = [aTableView dequeueReusableCellWithIdentifier:@"Bookmark" forIndexPath:indexPath];
    bookmarkCell.bookmark = bookmark;
    bookmarkCell.titleLabel.text = bookmark.title;
    bookmarkCell.imageView.image = bookmark.favicon;

    return bookmarkCell;
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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickEdit:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        [self.editButton setTitle: @"Edit"];
    } else {
        [self.tableView setEditing:YES animated:YES];
        [self.editButton setTitle: @"Done"];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [FLTRBookmarksCollection deleteBookmark: (int)indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    
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
