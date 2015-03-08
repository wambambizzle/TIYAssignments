//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Jordan Anderson on 3/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain
{
    CalculatorBrain *brain;
}

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
//        _decimalPointLocal = DecimalPointLocalNoObjCreated;
    }
    
    return self;
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
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 + self.operand2;
            break;
        case OperatorTypeSubtraction:
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 - self.operand2;
            break;
        case OperatorTypeMultiplication:
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 * self.operand2;
            break;
        case OperatorTypeDivision:
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
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
            [self.operand1String appendString:@"."];
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
    else if (![self.operand1String containsString:@"."] || ![self.operand2String containsString:@"."])
    {
        
    }
    
    return rc;
    
//    NSString *returnValue;
//    
//    switch (_decimalPointLocal)
//    {
//        case DecimalPointLocalNoObjCreated:
//            self.operand1String = [@"0." mutableCopy];
//            returnValue = self.operand1String;
//            break;
////        case DecimalPointLocalAlreadyExist:
////            if (<#condition#>)
////            {
////                <#statements#>
////            }
////            break;
//        case DecimalPointLocalOperandOne:
//            if (_operatorType == OperatorTypeNone)
//            {
//              returnValue = [self.operand1String appendString:@"."];
//            }
//            break;
//        case DecimalPointLocalOperandTwo:
//            if (brain.operand2String)
//            {
//                [brain.operand2String appendString:@"."];
//            }
//            break;
//            
//        default:
//            break;
//    }
//    
//    return returnValue;
//}




       
}




@end
