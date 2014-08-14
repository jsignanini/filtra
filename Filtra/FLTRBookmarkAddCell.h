//
//  FLTRBookmarkAddCell.h
//  Filtra
//
//  Created by José Signanini on 8/13/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLTRBookmarkAddCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UILabel *urlLabel;
@property (strong, nonatomic) IBOutlet UIImageView *faviconImage;

@end
