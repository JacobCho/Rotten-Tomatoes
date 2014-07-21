//
//  Movies.m
//  Rotten Tomatoes
//
//  Created by Jacob Cho on 2014-07-18.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "Movies.h"

@implementation Movies

-(id) initWithTitle:(NSString *)title {
    self = [super init];
    
    if (self) {
        self.title = title;
        self.thumbnail = nil;

    }
    
    return self;
}

+ (id) movieWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (NSURL *) thumbnailURL {
    
    return [NSURL URLWithString:self.thumbnail];
}

- (NSURL *) detailPosterURL {
    
    NSString *detailPoster = [self.thumbnail stringByReplacingOccurrencesOfString:@"tmb" withString:@"det"];
    return [NSURL URLWithString:detailPoster];
}

- (NSString *) formattedDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *tempDate = [dateFormatter dateFromString:self.date];
    
    [dateFormatter setDateFormat:@"EE, MMMM dd"];
    return [dateFormatter stringFromDate:tempDate];
}



@end
