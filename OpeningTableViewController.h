//
//  OpeningTableViewController.h
//  Rotten Tomatoes
//
//  Created by Jacob Cho on 2014-07-20.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>

#define API_KEY @"f95nzzmyhj57sx8ds3as8cfu"
#define RT_URL @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/opening.json?apikey="

@interface OpeningTableViewController : UITableViewController


@property (nonatomic) NSMutableArray *movies;

@end
