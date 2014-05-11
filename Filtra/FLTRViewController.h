//
//  FLTRViewController.h
//  Filtra
//
//  Created by José Signanini on 5/10/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLTRViewController : UIViewController <UITextFieldDelegate, UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIProgressView *progressBar;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *forwardButton;
@property (nonatomic, strong) IBOutlet UIButton *reloadStopButton;


@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic) BOOL pageLoaded;

@end
