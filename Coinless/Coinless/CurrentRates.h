//
//  CurrentRates.h
//  Coinless
//
//  Created by Jordan Anderson on 4/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentRates : NSObject

- (instancetype)initWithRate:(NSString *)rate code:(NSString *)code symbol:(NSString *)symbol;

@property (strong, nonatomic) NSString *rate;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *symbol;

@end
