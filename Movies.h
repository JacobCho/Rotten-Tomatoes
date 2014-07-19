//
//  Movies.h
//  Rotten Tomatoes
//
//  Created by Jacob Cho on 2014-07-18.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movies : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *thumbnail;
@property (nonatomic) NSString *date;
@property (nonatomic) NSString *synopsis;
@property (nonatomic) NSArray *cast;

@property (nonatomic) NSString *critics_rating;
@property (nonatomic) NSInteger critics_score;
@property (nonatomic) NSInteger audience_score;

- (id) initWithTitle:(NSString *)title;
+ (id) movieWithTitle:(NSString *)title;
- (NSURL *) thumbnailURL;
- (NSString *)formattedDate;


@end
