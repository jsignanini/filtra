//
//  FLTRBookmarkCell.h
//  Filtra
//
//  Created by José Signanini on 7/30/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLTRBookmark.h"

@interface FLTRBookmarkCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *faviconView;
@property (strong, nonatomic) FLTRBookmark *bookmark;

@end
