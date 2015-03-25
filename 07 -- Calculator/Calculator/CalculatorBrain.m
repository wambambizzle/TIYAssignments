//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Jordan Anderson on 3/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain
//{
//    CalculatorBrain *brain;
//}

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _operand1String = [[NSMutableString alloc] init];
        _operand2String = [[NSMutableString alloc] init];
        _operand1 = 0.0f;
        _operand2 = 0.0f;
        _operatorType = OperatorTypeNone;
        _userIsTypingANumber = NO;

    }
    
    return self;
}

- (void) stringToFloat
{
    self.operand1 = [self.operand1String floatValue];
    self.operand2 = [self.operand2String floatValue];
}

- (NSString *) addOperandDigit:(NSString *)digit
{
    NSString *rc;
    if (self.operatorType == OperatorTypeNone)
    {
        [self.operand1String appendString:digit];
        rc = self.operand1String;
    }
    else
    {
        [self.operand2String appendString:digit];
        rc = self.operand2String;
    }
    
    return rc;
}

- (float) preformCalculation
{
    float returnValue;
    switch (_operatorType)
    {
        case OperatorTypeAddition:
            [self stringToFloat];
            returnValue = self.operand1 + self.operand2;
            break;
        case OperatorTypeSubtraction:
            [self stringToFloat];
            returnValue = self.operand1 - self.operand2;
            break;
        case OperatorTypeMultiplication:
            [self stringToFloat];
            returnValue = self.operand1 * self.operand2;
            break;
        case OperatorTypeDivision:
            [self stringToFloat];
            returnValue = self.operand1 / self.operand2;
            break;
            
        default:
            break;
    }
    return returnValue;

}

- (NSString *) insertDecimalPoint
{
    NSString *rc;

    if (self.operatorType == OperatorTypeNone)
    {
        if (![self.operand1String containsString:@"."])
        {
            [self.operand1String appendString:@"0."];
        }
        
        rc = self.operand1String;
        
    }
    else if ([self.operand2String isEqualToString:@""])
    {
        self.operand2String = [@"0." mutableCopy];
        rc = self.operand2String;
        
    }
    else if (self.operand2String)
    {
        if (![self.operand2String containsString:@"."])
        {
            [self.operand2String appendString:@"."];
        }
        
        rc = self.operand2String;
        
    }

    return rc;
       
}

- (NSString *) percentConversion
{
     NSString *rc;
    
    
        if (self.operatorType == OperatorTypeNone)
        {
           [self stringToFloat];
            float percentAnswer = self.operand1 * .01;
            rc = [NSMutableString stringWithFormat:@"%g",percentAnswer];
            self.operand1String = [rc copy];
        }
        else if(self.operatorType != OperatorTypeNone)
        {
            [self stringToFloat];
            float percentAnswer = self.operand2 * .01;
            rc = [NSMutableString stringWithFormat:@"%g", percentAnswer];
            self.operand2String = [rc copy];
        }
    return rc;
}

- (float) changeToPositiveOrNegative
{
    float rc;
    [self stringToFloat];
   
    if (self.operatorType == OperatorTypeNone)
    {
        float signChange = self.operand1 * -1;
        self.operand1String = [NSMutableString stringWithFormat:@"%g", signChange];
        rc = signChange;
        
    }
    else if (self.operatorType != OperatorTypeNone)
    {
        float signChange = self.operand2 * -1;
        self.operand2String = [NSMutableString stringWithFormat:@"%g", signChange];
        rc = signChange;
    }
    
    return rc;
}



@end
