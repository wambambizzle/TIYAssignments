//
//  CalculatorBrain+Extras.m
//  Calculator
//
//  Created by Jordan Anderson on 3/11/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CalculatorBrain+Extras.h"

@implementation CalculatorBrain (Extras)

-(float)squareRootofNumb
{
    float rc;
    if (self.operatorType == OperatorTypeNone)
    {
        self.operand1 = [self.operand1String floatValue];
        
        float squareRootAnswer = sqrt(self.operand1);
        self.operand1String = [NSMutableString stringWithFormat:@"%g", squareRootAnswer];
        rc = squareRootAnswer;
    }
    
    else if (self.operatorType != OperatorTypeNone)
    {
        self.operand2 = [self.operand2String floatValue];
        
        float squareRootAnswer = sqrt(self.operand2);
        self.operand2String = [NSMutableString stringWithFormat:@"%g", squareRootAnswer];
        rc = squareRootAnswer;
    }
    
    return rc;
}

-(float)squaredNumber
{
    float rc;
    if (self.operatorType == OperatorTypeNone)
    {
        self.operand1 = [self.operand1String floatValue];
        
        float squaredNumberAnswer = self.operand1 * self.operand1;
        self.operand1String = [NSMutableString stringWithFormat:@"%g", squaredNumberAnswer];
        rc = squaredNumberAnswer;
    }
    
    else if (self.operatorType != OperatorTypeNone)
    {
        self.operand2 = [self.operand2String floatValue];
        
        float squaredNumberAnswer = self.operand2 * self.operand2;
        self.operand2String = [NSMutableString stringWithFormat:@"%g", squaredNumberAnswer];
        rc = squaredNumberAnswer;
    }

    return rc;
}

@end
