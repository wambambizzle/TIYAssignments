//
//  ViewController.m
//  Calculator
//
//  Created by Jordan Anderson on 3/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain+Extras.h"

@interface ViewController ()
{
    CalculatorBrain *brain;
}

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

-(IBAction)operandTapped:(UIButton *)sender;

-(IBAction)allClearButton:(UIButton *)sender;
-(IBAction)decimalPointButton:(UIButton *)sender;
-(IBAction)percentConvertButton:(UIButton *)sender;

- (IBAction)changeSignButton:(UIButton *)sender;
- (IBAction)sqaureRootButton:(UIButton *)sender;
- (IBAction)squareANumber:(UIButton *)sender;


-(IBAction)additionTapped:(UIButton *)sender;
-(IBAction)subtractionTapped:(UIButton *)sender;
-(IBAction)multiplicationTapped:(UIButton *)sender;
-(IBAction)divisionTapped:(UIButton *)sender;
-(IBAction)equalTapped:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Calculator";
    self.displayLabel.text = @"0";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)operandTapped:(UIButton *)sender
{
    
    if (!brain)
    {
        brain =[[CalculatorBrain alloc] init];
    }
        
    self.displayLabel.text = [brain addOperand:sender.titleLabel.text];
   

}

#pragma mark - Actions Handlers 

-(IBAction)additionTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeAddition;
    
}

-(IBAction)subtractionTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeSubtraction;
}

-(IBAction)multiplicationTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeMultiplication;
}

-(IBAction)divisionTapped:(UIButton *)sender
{       
    brain.operatorType = OperatorTypeDivision;
}


-(IBAction)equalTapped:(UIButton *)sender
{
    float returnValue = [brain useOperator];
    
    if ((brain.operatorType == OperatorTypeDivision) && (brain.operand2 == 0))
    {
        self.displayLabel.text = @"Error";
    }
    else
    {
        self.displayLabel.text = [NSString stringWithFormat:@"%g", returnValue];
        
    }
    brain = nil;
    
}

-(IBAction)allClearButton:(UIButton *)sender
{
       brain = nil;
       self.displayLabel.text = @"0";
    
}

-(IBAction)decimalPointButton:(UIButton *)sender
{
    if (!brain)
    {
        brain =[[CalculatorBrain alloc] init];
    }
    self.displayLabel.text = [brain addDecimalPoint];
}

// COME BACK LATER SUCKA! JNA - fix % calculations

-(IBAction)percentConvertButton:(UIButton *)sender
{
    self.displayLabel.text = [NSString stringWithFormat:@"%g",[brain findPercent]];
    
//    if (brain)
//    {
//        
//        if (![brain.operand1String isEqualToString:@""])
//        {
//            float opReturn = [brain.operand1String floatValue];
//            self.displayLabel.text = [NSString stringWithFormat:@"%.2f ",opReturn * .01];
//        }
//        
//    }

}

- (IBAction)changeSignButton:(UIButton *)sender
{
    
    self.displayLabel.text = [NSString stringWithFormat:@"%g",[brain changePositiveNegative]];
}

- (IBAction)sqaureRootButton:(UIButton *)sender

{
    if  ([brain.operand1String containsString:@"-"] || [brain.operand2String containsString:@"-"])
    {
        self.displayLabel.text = @"Error";
    }
    else
    {
      self.displayLabel.text = [NSString stringWithFormat:@"%g",[brain squareRootofNumb]];
    }
}

- (IBAction)squareANumber:(UIButton *)sender
{
   
    {
       self.displayLabel.text = [NSString stringWithFormat:@"%g", [brain squaredNumber]];
    }
}



@end
