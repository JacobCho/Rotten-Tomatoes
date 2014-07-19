//
//  TableViewController.m
//  Rotten Tomatoes
//
//  Created by Jacob Cho on 2014-07-18.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "TableViewController.h"
#import "Movies.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBarColor];
    
    NSString *API_KEY = @"f95nzzmyhj57sx8ds3as8cfu";
    
    NSString *URL = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=%@",API_KEY];
    
    NSURL *rtURL = [NSURL URLWithString:URL];
    NSData *data = [NSData dataWithContentsOfURL:rtURL];
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
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
        movie.audience_score = (NSInteger)[movie.rating objectForKey:@"audience_score"];
        
        [self.movies addObject:movie];
        
    }
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Movies *movie = [self.movies objectAtIndex:indexPath.row ];
    
    // Set thumbnail image for cell
    NSData *imageData = [NSData dataWithContentsOfURL:movie.thumbnailURL];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.imageView.image = image;
    
    // Set movie title for cell
    cell.textLabel.text = movie.title;
   
    // Set critics score in detailTextLabel
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d%%",movie.critics_score];
    
    return cell;
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
