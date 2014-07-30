//
//  FLTRViewController.h
//  Filtra
//
//  Created by José Signanini on 5/10/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLTRTab.h"

@interface FLTRViewController : UIViewController <UITextFieldDelegate>



@property FLTRTab *currentTab;

@property (nonatomic, strong) IBOutlet UITextField *addressField;
@property (nonatomic, strong) IBOutlet UIProgressView *progressBar;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *forwardButton;
@property (nonatomic, strong) IBOutlet UIButton *reloadStopButton;
@property (strong, nonatomic) IBOutlet UIView *tabsView;

@end
