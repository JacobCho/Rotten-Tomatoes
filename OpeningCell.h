//
//  OpeningCell.h
//  Rotten Tomatoes
//
//  Created by Jacob Cho on 2014-07-20.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpeningCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieRating;
@property (weak, nonatomic) IBOutlet UIImageView *freshImage;



@end
