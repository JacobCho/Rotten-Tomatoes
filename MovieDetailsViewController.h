//
//  MovieDetailsViewController.h
//  Rotten Tomatoes
//
//  Created by Jacob Cho on 2014-07-19.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *criticsScore;
@property (weak, nonatomic) IBOutlet UILabel *audienceScore;
@property (weak, nonatomic) IBOutlet UITextView *synopsis;
@property (weak, nonatomic) IBOutlet UIImageView *criticsTomato;
@property (weak, nonatomic) IBOutlet UIImageView *popcorn;
@property (weak, nonatomic) IBOutlet UILabel *movieDate;
@property (weak, nonatomic) IBOutlet UILabel *cast;

@property (nonatomic) NSMutableArray *movies;


@end
