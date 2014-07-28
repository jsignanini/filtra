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

@interface FLTRViewController ()

@end

@implementation FLTRViewController

@synthesize tabsView, textField, progressBar, myTimer, pageLoaded, backButton, forwardButton, reloadStopButton;

- (IBAction)testclick
{
//    [UIView animateWithDuration:1.0
//                     animations:
//                        ^{
//                         CGRect frame = self.tabsView.frame;
//                         frame.size.height = 180.0;
//                         frame.size.width = 103.0;
//                         self.tabsView.frame = frame;
//                     }
//                     completion:^(BOOL finished){
//                         // whatever you need to do when animations are complete
//                     }];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    CGRect frame = self.tabsView.frame;
    frame.size.height = 180.0;
    frame.size.width = 103.0;
    self.tabsView.frame = frame;
    [UIView commitAnimations];

}















- (IBAction)handleReloadStopButtonClick:(id)sender
{
    if (reloadStopButton.selected) {
        [self.currentTab.webView stopLoading];
    } else {
        [self.currentTab.webView reload];
    }
    
    reloadStopButton.selected = !reloadStopButton.selected;
}

- (void)updateBackForwardButtons:(UIWebView *)theWebView
{
    backButton.enabled = theWebView.canGoBack;
    forwardButton.enabled = theWebView.canGoForward;
}

- (BOOL)textFieldShouldReturn:(UITextField *)field
{
    [field resignFirstResponder];
    [self.currentTab loadUrlOrSearch: [textField text]];
    return YES;
}

-(void)updateAddressBar:(NSString *)url
{
    textField.text = url;
}

- (void) switchToTabAtIndex:(NSInteger) index
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
}

- (void)viewDidLoad
{
    [self switchToTabAtIndex: 0];
    
    
    
    
    
    
    progressBar.progress = 0;
    progressBar.hidden = YES;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.delegate = self;
    
    [reloadStopButton setImage:[UIImage imageNamed:@"reload.png"] forState:UIControlStateNormal];
    [reloadStopButton setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateSelected];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // TODO
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[FLTRTabsViewController class]]) {
//        FLTRTabsViewController *viewController = segue.sourceViewController;
        [self switchToTabAtIndex: [FLTRTabsCollection getCurrentTabIndex]];
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