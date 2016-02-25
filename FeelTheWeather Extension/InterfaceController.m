//
//  InterfaceController.m
//  FeelTheWeather Extension
//
//  Created by Ayuna Vogel on 2/24/16.
//  Copyright © 2016 Ayuna Vogel. All rights reserved.
//

#import "InterfaceController.h"

#define ForecastIoAPIKey @"8040fc5b15adaaafabbe7de9c3ff5458"


@interface InterfaceController()

@property (nonatomic) NSString *weatherSummary;
@property (nonatomic) NSString *temperature;
@property (nonatomic) NSString *weatherIconName;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *temperatureLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *emojiLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *weatherSummaryLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *weatherIconImage;
- (IBAction)refreshButtonTapped;

@end


@implementation InterfaceController

#pragma mark - API Data setup

- (void)fetchAPIData {
    
    NSDictionary *emojis = [[NSDictionary alloc]initWithObjectsAndKeys:@"😎", @"clear-day", @"🌧", @"rain", @"⛅️", @"cloudy", @"🌫", @"fog", @"🌤", @"partly-cloudy-day", @"✨", @"clear-night", @"☁️", @"partly-cloudy-night", @"☃️", @"sleet", @"❄️", @"snow", @"💨", @"wind", nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"https://api.forecast.io/forecast/8040fc5b15adaaafabbe7de9c3ff5458/40.759863,%20-73.920546"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             //NSLog(@"JSON: %@", responseObject);
             NSArray *results = responseObject[@"daily"][@"data"];
             //NSLog(@"results %@", results);
             
             self.weatherSummary = results[0][@"summary"];
             NSLog(@"weather summary is %@", self.weatherSummary);
             self.weatherSummaryLabel.text = self.weatherSummary;
             
             self.temperature = [NSString stringWithFormat:@"%.0FF", [results[0][@"temperatureMax"] doubleValue]];
             NSLog(@"self.temperature is %@", self.temperature);
             self.temperatureLabel.text = self.temperature;
             
             self.weatherIconName = results[0][@"icon"];
             NSLog(@"self.weatherIconName is %@", self.weatherIconName);
//             [self.weatherIconImage setImageNamed:self.weatherIconName];
             
             self.emojiLabel.text = [emojis objectForKey:self.weatherIconName];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
         }];
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [self fetchAPIData];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)refreshButtonTapped {
    
    NSLog(@"Button is tapped");
    
    [self fetchAPIData];
}

@end



