//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Jordan Anderson on 3/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    OperatorTypeNone,
    OperatorTypeAddition,
    OperatorTypeSubtraction,
    OperatorTypeMultiplication,
    OperatorTypeDivision
} OperatorType;


@interface CalculatorBrain : NSObject

@property (strong, nonatomic) NSMutableString *operand1String;
@property (strong, nonatomic) NSMutableString *operand2String;

@property (assign) float operand1;
@property (assign) float operand2;
@property (assign) OperatorType operatorType;
@property (assign) BOOL userIsTypingANumber;

- (NSString *) addOperandDigit:(NSString *)digit;
- (NSString *) insertDecimalPoint;

- (float) preformCalculation;
- (NSString *) percentConversion;
- (float) changeToPositiveOrNegative;


@end
