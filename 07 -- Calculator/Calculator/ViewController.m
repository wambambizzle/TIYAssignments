//
//  ViewController.m
//  Calculator
//
//  Created by Jordan Anderson on 3/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
{
    CalculatorBrain *brain;
}

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

-(IBAction)operandTapped:(UIButton *)sender;

-(IBAction)allClearButton:(UIButton *)sender;
-(IBAction)decimalPointButton:(UIButton *)sender;
-(IBAction)percentConvertButton:(UIButton *)sender;

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
        
    self.displayLabel.text = [brain addOperandDigit:sender.titleLabel.text];
   

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
    float returnValue = [brain preformCalculation];
    
    if ((brain.operatorType == OperatorTypeDivision) && (brain.operand2 == 0))
    {
        self.displayLabel.text = @"Error";
    }
    else
    {
        self.displayLabel.text = [NSString stringWithFormat:@"%g", returnValue];
    }
    
}

-(IBAction)allClearButton:(UIButton *)sender
{

 if (brain)

   {
       brain = nil;
       self.displayLabel.text = @"0";
      
   }
    
}

-(IBAction)decimalPointButton:(UIButton *)sender
{
    if (!brain)
    {
        brain =[[CalculatorBrain alloc] init];
    }
    self.displayLabel.text = [brain insertDecimalPoint];
}

// COME BACK LATER SUCKA! JNA - fix % calculations

-(IBAction)percentConvertButton:(UIButton *)sender
{
    
    NSString *percent = [brain percentConversion];
    self.displayLabel.text = percent;
    
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



@end
