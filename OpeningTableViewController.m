//
//  OpeningTableViewController.m
//  Rotten Tomatoes
//
//  Created by Jacob Cho on 2014-07-20.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "OpeningTableViewController.h"
#import "Movies.h"
#import "OpeningCell.h"
#import "MovieDetailsViewController.h"


@interface OpeningTableViewController ()

@end

@implementation OpeningTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBarColor];

    
    NSString *URL = [RT_URL stringByAppendingString:API_KEY];
    
    NSURL *rtURL = [NSURL URLWithString:URL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:rtURL];
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.movies = [NSMutableArray array];
            
            NSArray *moviesArray = [dataDictionary objectForKeyedSubscript:@"movies"];
            
            for (NSDictionary *moviesDictionary in moviesArray) {
                
                Movies *movie = [Movies movieWithTitle:[moviesDictionary objectForKey:@"title"]];
                // "Posters" is a JSON Object within "Title"
                movie.posters = [moviesDictionary objectForKey:@"posters"];
                // "Thumbnail is an Object within "Posters"
                movie.thumbnail = [movie.posters objectForKey:@"thumbnail"];
                
                movie.synopsis = [moviesDictionary objectForKey:@"synopsis"];
                
                // "Release_dates is a JSON object within "Title"
                movie.release_dates = [moviesDictionary objectForKey:@"release_dates"];
                // "Theater" is an Object within "Release_dates"
                movie.date = [movie.release_dates objectForKey:@"theater"];
                
                // "Rating" is a JSON Object within "Title"
                movie.rating = [moviesDictionary objectForKey:@"ratings"];
                // Scores are JSON Objects within "Rating"
                movie.critics_rating = [movie.rating objectForKey:@"critics_rating"];
                movie.critics_score = [[movie.rating objectForKey:@"critics_score"]intValue];
                movie.audience_score = [[movie.rating objectForKey:@"audience_score"]intValue];
                
                
                [self.movies addObject:movie];
                
            }

        });
    });

    

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.movies.count;
}

- (void)setNavBarColor
{
    // Set navigation bar color to flat green
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:46.0/255.0 green:204.0/255.0 blue:113.0/255.0 alpha:1.0];
    // Set navigation bar text color to white
    NSMutableDictionary *textAttributes = [[NSMutableDictionary alloc] initWithDictionary:self.navigationController.navigationBar.titleTextAttributes];
    [textAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OpeningCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Movies *movie = [self.movies objectAtIndex:indexPath.row ];
    
    // Set thumbnail image for cell
    NSData *imageData = [NSData dataWithContentsOfURL:movie.thumbnailURL];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.thumbnail.image = image;
    
    // Set movie title for cell
    cell.movieTitle.text = movie.title;
    
    // Set critics score in detailTextLabel
    cell.movieRating.text = [NSString stringWithFormat:@"%d",movie.critics_score];
    
    if (movie.critics_score > 50) {
        UIImage *freshImage = [UIImage imageNamed:@"flattomato"];
        cell.freshImage.image = freshImage;
    } else {
        UIImage *freshImage = [UIImage imageNamed:@"flatrotten"];
        cell.freshImage.image = freshImage;
    }

    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"openingMovieDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Movies *movie = [self.movies objectAtIndex:indexPath.row];
        MovieDetailsViewController *details = (MovieDetailsViewController *)segue.destinationViewController;
        
        details.movies = movie;
        
    }


}


@end
