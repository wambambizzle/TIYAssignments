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

-(IBAction)additionTapped:(UIButton *)sender;
-(IBAction)subtractionTapped:(UIButton *)sender;
-(IBAction)multiplicationTapped:(UIButton *)sender;
-(IBAction)divisionTapped:(UIButton *)sender;
-(IBAction)equalTapped:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.displayLabel.text = @"0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)operandTapped:(UIButton *)sender
{
    if (!brain)
    {
         brain =[[CalculatorBrain alloc] init];
    }
   
    if (brain.operatorType == OperatorTypeNone)
    {
        [brain.operand1String appendString:sender.titleLabel.text];
        
        self.displayLabel.text = brain.operand1String;
    }
    else
    {
        [brain.operand2String appendString:sender.titleLabel.text];
        self.displayLabel.text = brain.operand2String;
    }
    
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
    
    brain.operand1 = [brain.operand1String floatValue];
    brain.operand2 = [brain.operand2String floatValue];
    
    if (brain.operatorType == OperatorTypeAddition)
    {
        float additionAnswer = brain.operand1 + brain.operand2;
        self.displayLabel.text = [NSString stringWithFormat:@"%.0f", additionAnswer];
    }
    
    else if (brain.operatorType == OperatorTypeSubtraction)
    {
        float subtractionAnswer = brain.operand1 - brain.operand2;
        self.displayLabel.text = [NSString stringWithFormat:@"%.0f", subtractionAnswer];
    }
    
    else if (brain.operatorType == OperatorTypeMultiplication)
    {
        float multiplicationAnswer = brain.operand1 * brain.operand2;
        self.displayLabel.text = [NSString stringWithFormat:@"%.0f", multiplicationAnswer];
    }

    else if (brain.operatorType == OperatorTypeDivision)
    {
        float divisionAnswer = brain.operand1 / brain.operand2;
        self.displayLabel.text = [NSString stringWithFormat:@"%.0f", divisionAnswer];
    }
    
}

-(IBAction)allClearButton:(UIButton *)sender
{
 if (brain)

   {
        self.displayLabel.text = @"0";
        brain = Nil;

    }
    
    
}





@end
