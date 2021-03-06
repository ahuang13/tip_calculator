//
//  TipViewController.m
//  tipcalculator
//
//  Created by Angus Huang on 12/3/13.
//  Copyright (c) 2013 Angus Huang. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;

- (void)updateValues;
- (void)onSettingsButton;

@end

@implementation TipViewController

//==============================================================================
#pragma mark - Initializers
//==============================================================================

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

//==============================================================================
#pragma mark - View Lifecycle Methods
//==============================================================================

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add "Settings" button to the right side of the title bar.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    [self updateValues];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Initialize the SegmentedControl with the default tip percentage only if
    // the amount text field is not already filled in.
    if ([self.billTextField.text isEqualToString:@""]) {
        [SettingsViewController setDefaultSelectedIndex:self.tipControl];
    }
}

//==============================================================================
#pragma mark - IBAction Methods
//==============================================================================

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

//==============================================================================
#pragma mark - Private Methods
//==============================================================================

- (void)updateValues {
    
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
