//
//  OpeningCell.m
//  Rotten Tomatoes
//
//  Created by Jacob Cho on 2014-07-20.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "OpeningCell.h"

@implementation OpeningCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
