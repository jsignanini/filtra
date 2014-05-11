//
//  FLTRViewController.m
//  Filtra
//
//  Created by José Signanini on 5/10/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import "FLTRViewController.h"

@interface FLTRViewController ()

@end

@implementation FLTRViewController

@synthesize webView, textField, progressBar, myTimer, pageLoaded, backButton, forwardButton, reloadStopButton;


- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
    
}


- (IBAction)handleReloadStopButtonClick:(id)sender
{
    if (reloadStopButton.selected) {
        [webView stopLoading];
    } else {
        [webView reload];
    }
    
    reloadStopButton.selected = !reloadStopButton.selected;
}

- (void)updateBackForwardButtons:(UIWebView *)theWebView
{
    backButton.enabled = theWebView.canGoBack;
    forwardButton.enabled = theWebView.canGoForward;
}

- (void)startLoadingProgressBar
{
    progressBar.progress = 0;
    progressBar.hidden = NO;
    pageLoaded = false;
    //0.01667 is roughly 1/60, so it will update at 60 FPS
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01667 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
}
- (void)timerCallback
{
    if (pageLoaded) {
        if (progressBar.progress >= 1) {
            progressBar.hidden = YES;
            [myTimer invalidate];
        }
        else {
            progressBar.progress += 0.1;
        }
    }
    else {
        progressBar.progress += 0.05;
        if (progressBar.progress >= 0.95) {
            progressBar.progress = 0.95;
        }
    }
}


- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    self.pageLoaded = YES;
    reloadStopButton.selected = NO;
    [self updateBackForwardButtons: theWebView];
}

- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL isFrame = ![[[request URL] absoluteString] isEqualToString:[[request mainDocumentURL] absoluteString]];
    
    if (isFrame) {
        //        NSLog(@"Frame: %@", request.URL.absoluteString);
        
    } else {
        //        NSLog(@"Loading: %@", request.URL.absoluteString);
        
        NSString *urlLoading = request.URL.absoluteString;
        if ([urlLoading length] > 0) {
            [self updateAddressBar: urlLoading];
            if (![myTimer isValid]) {
                [self startLoadingProgressBar];
            }
        }
    }
    
    //    return ! self.pageLoaded;
    reloadStopButton.selected = YES;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)field
{
    [field resignFirstResponder];
    
    //    [self updateAddressBar: [textField text]];
    [self loadUrlOrSearch: [textField text]];
    
    return YES;
}

-(void)updateAddressBar:(NSString *)url
{
    textField.text = url;
}

- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

- (void)loadUrlOrSearch:(NSString *)text
{
    if ([self validateUrl:text]) {
        NSURLRequest *requestURL = [NSURLRequest requestWithURL:[NSURL URLWithString:text]];
        [webView loadRequest:requestURL];
    } else {
        // TODO Do DuckDuckGo search
        //        [self updateAddressBar: [NSString stringWithFormat:@"http://www.google.com/search?q=%@", text]];
        NSURLRequest *requestURL = [NSURLRequest requestWithURL:
                                    [NSURL URLWithString: [NSString stringWithFormat:@"http://www.google.com/search?q=%@", text]]];
        [webView loadRequest:requestURL];
    }
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        webView.scalesPageToFit = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    
    progressBar.progress = 0;
    progressBar.hidden = YES;
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.delegate = self;
    
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    
    [reloadStopButton setImage:[UIImage imageNamed:@"reload.png"] forState:UIControlStateNormal];
    [reloadStopButton setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateSelected];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(webViewFinalLoad:)
                                                 name:@"WebViewProgressFinishedNotification"
                                               object:webView];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) webViewFinalLoad:(id) sender
{
    NSLog(@"NOTIFIED!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // TODO
    // Dispose of any resources that can be recreated.
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