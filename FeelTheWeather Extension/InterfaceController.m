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

@property (nonatomic) NSArray *weatherArray;
@property (nonatomic) NSString *weatherSummary;
@property (nonatomic) NSString *temperature;
@property (nonatomic) NSString *weatherIconName;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *temperatureLabel;

@end


@implementation InterfaceController

#pragma mark - API Data setup

- (void)fetchAPIData {
    
    self.weatherArray = [[NSArray alloc]init];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"https://api.forecast.io/forecast/8040fc5b15adaaafabbe7de9c3ff5458/40.759863,%20-73.920546"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             //NSLog(@"JSON: %@", responseObject);
             NSArray *results = responseObject[@"daily"][@"data"];
             NSLog(@"results %@", results);
             
             self.weatherSummary = results[0][@"summary"];
             NSLog(@"weather summary is %@", self.weatherSummary);
             self.weatherSummaryLabel.text = self.weatherSummary;
      
             self.temperature = [NSString stringWithFormat:@"%.0F", [results[0][@"temperatureMax"] doubleValue]];
             NSLog(@"self.temperature is %@", self.temperature);
             self.temperatureLabel.text = self.temperature;
             
             self.weatherIconName = results[0][@"icon"];
             [self.weatherIconImage setImageNamed:self.weatherIconName];
             
             
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
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)updateWeatherData {
    
    NSLog(@"Button is tapped");
    
    [self fetchAPIData]; 
    
//    NSURLRequest *requestForWeatherData = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.forecast.io/forecast/8040fc5b15adaaafabbe7de9c3ff5458/40.759863,%20-73.920546"]];
////    NSURLResponse *response = nil;
////    NSError *error = nil;
//    
//    [[NSURLSession sharedSession] dataTaskWithRequest:requestForWeatherData
//                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                        
//                                        NSLog(@"data %@", data);
//                                        NSLog(@"response %@", response);
//                                        NSLog(@"error %@", error);
//                                        
    
                                        
//        NSMutableDictionary *allData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]; //data in serialized view
//        NSString *currentWeather = nil;
//                                        
//        NSArray *weather = allData[@"weather"];
//                                        
//        for (NSDictionary *weatherDictionary in weather)
//            {
//                currentWeather = weatherDictionary[@"main"];
//            }
//    }];
    
    
//    NSData *data = [NSURLConnection  sendSynchronousRequest:requestForWeatherData returningResponse:&response error:&error]; //for saving all of received data in non-serialized view
    
    
    
}
@end



