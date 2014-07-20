//
//  MovieDetailsViewController.m
//  Rotten Tomatoes
//
//  Created by Jacob Cho on 2014-07-19.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "Movies.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    Movies *movie = self.movies;
    
    NSData *imageData = [NSData dataWithContentsOfURL:movie.detailPosterURL];
    
    UIImage *image = [UIImage imageWithData:imageData];
    self.poster.image = image;
    
    self.criticsScore.text = [NSString stringWithFormat:@"%d%%",movie.critics_score];
    self.audienceScore.text = [NSString stringWithFormat:@"%d%%",movie.audience_score];
    self.synopsis.text = movie.synopsis;
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
