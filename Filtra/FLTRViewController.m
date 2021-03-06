//
//  FLTRViewController.m
//  Filtra
//
//  Created by José Signanini on 5/10/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import "FLTRViewController.h"
#import "FLTRTabsViewController.h"
#import "FLTRTabsCollection.h"
#import "FLTRBookmarkActivity.h"
#import "FLTRBookmarksViewController.h"
#import "FLTRBookmarkAddViewController.h"

@interface FLTRViewController ()

@end

@implementation FLTRViewController

@synthesize tabsView, addressField, progressBar, backButton, forwardButton, reloadStopButton, activityView;

- (IBAction)clickedReloadStopButton:(id)sender
{
    if (self.reloadStopButton.selected) {
        [self.currentTab.webView stopLoading];
    } else {
        [self.currentTab.webView reload];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)field
{
    [field resignFirstResponder];
    [self.currentTab loadUrlOrSearch: [addressField text]];
    return YES;
}

- (void) switchToTabAtIndex:(NSUInteger) index
{
    NSMutableArray *tabs = [FLTRTabsCollection getTabs];
    for (FLTRTab *tab in tabs) {
        tab.webView.hidden = YES;
    }
    FLTRTab *new = [tabs objectAtIndex: index];
    
    self.currentTab = new;
    
    if (![[self.tabsView subviews] containsObject: new.webView]) {
        [self.tabsView addSubview: new.webView];
    }
    new.webView.hidden = NO;
    
    [self updateUI];
}

- (void) updateUI
{
    [self.addressField setText: self.currentTab.webView.request.URL.absoluteString];
    [self.backButton setEnabled: self.currentTab.webView.canGoBack];
    [self.forwardButton setEnabled: self.currentTab.webView.canGoForward];
}

- (void)viewDidLoad
{
    [self switchToTabAtIndex: 0];
    progressBar.progress = 0;
    progressBar.hidden = YES;
    addressField.autocorrectionType = UITextAutocorrectionTypeNo;
    addressField.delegate = self;
    
    [reloadStopButton setImage:[UIImage imageNamed:@"reload.png"] forState:UIControlStateNormal];
    [reloadStopButton setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateSelected];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewDidFinishLoad)  name:@"webViewFinishedLoad" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewDidStartLoad)  name:@"webViewStartedLoad" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewSentProgress:)  name:@"webViewProgress" object:nil];
    
    

}

- (void) webViewSentProgress: (NSNotification *) notification
{
//    NSDictionary* userInfo = notification.userInfo;
//    [self.progressBar setProgress:[[userInfo objectForKey:@"progress"] floatValue] animated:[[userInfo objectForKey:@"animated"] boolValue]];
    if (self.progressBar.progress < 0.9f) {
        [self.progressBar setProgress: self.progressBar.progress+0.1f animated: YES];
    }
    [self updateUI];
}

- (void) webViewDidStartLoad
{
//    [self updateUI];
    self.reloadStopButton.selected = YES;
    [self.progressBar setProgress: 0.0f animated: NO];
    [self.progressBar setHidden: NO];
    [self.progressBar setProgress: 0.1f animated: YES];
}

- (void) webViewDidFinishLoad
{
    [self updateUI];
    self.reloadStopButton.selected = NO;
    [self.progressBar setProgress: 1.0f animated: YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(hideProgressBar) userInfo:nil repeats:NO];
}

- (void) hideProgressBar
{
    [self.progressBar setHidden: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // TODO
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[FLTRTabsViewController class]]
        || [segue.sourceViewController isKindOfClass:[FLTRBookmarksViewController class]]) {
        [self switchToTabAtIndex: [FLTRTabsCollection getCurrentTabIndex]];
    }
}

- (IBAction)webViewGoBack:(id)sender
{
    [self.currentTab.webView goBack];
}

- (IBAction)webViewGoForward:(id)sender
{
    [self.currentTab.webView goForward];
}

- (IBAction)share:(id)sender
{
    FLTRBookmarkActivity *activity = [[FLTRBookmarkActivity alloc] init];
    self.activityView = [[UIActivityViewController alloc] initWithActivityItems:@[self.currentTab.webView.request.URL.absoluteString, self.currentTab.webView.request.URL] applicationActivities: [NSArray arrayWithObject:activity]];
    
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.activityView setCompletionHandler:^(NSString *activity, BOOL success) {
        if ([activity isEqualToString: @"filtra.bookmark"]) {
            [weakSelf performSegueWithIdentifier:@"Bookmark Edit" sender:weakSelf];
        }
    }];
    
    [self presentViewController:self.activityView animated:YES completion: nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"Bookmark Edit"]) {
        FLTRBookmarkAddViewController *controller = (FLTRBookmarkAddViewController *) segue.destinationViewController;
        controller.url = self.currentTab.webView.request.URL.absoluteString;
        controller.title = self.currentTab.title;
    }
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