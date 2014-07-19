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
    
    
    NSString *API_KEY = @"f95nzzmyhj57sx8ds3as8cfu";
    
    NSString *URL = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/opening.json?apikey=%@",API_KEY];
    
    NSURL *rtURL = [NSURL URLWithString:URL];
    
    NSData *data = [NSData dataWithContentsOfURL:rtURL];
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    self.movies = [NSMutableArray array];
    
    NSArray *moviesArray = [dataDictionary objectForKeyedSubscript:@"movies"];
    
    
    for (NSDictionary *moviesDictionary in moviesArray) {
        
        Movies *movie = [Movies movieWithTitle:[moviesDictionary objectForKey:@"title"]];
        movie.thumbnail = [moviesDictionary objectForKey:@"thumbnail"];
        movie.synopsis = [moviesDictionary objectForKey:@"synopsis"];
        movie.date = [moviesDictionary objectForKey:@"date"];
        movie.critics_rating = [moviesDictionary objectForKey:@"critics_rating"];
        movie.critics_score = [moviesDictionary objectForKey:@"critics_score"];
        movie.audience_score = [moviesDictionary objectForKey:@"audience_score"];
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
    
    NSData *imageData = [NSData dataWithContentsOfURL:movie.thumbnailURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    cell.imageView.image = image;
    
    cell.textLabel.text = movie.title;
    
    return cell;
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
