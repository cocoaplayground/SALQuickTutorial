//
//  SALViewController.m
//  SALQuickTutorialExample
//
//  Created by Natan Rolnik on 8/12/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "SALViewController.h"
#import "SALQuickTutorialViewController.h"

static NSString *const SALProvidedBySAQuickTutorialKey = @"SALProvidedBySAQuickTutorialKey";

@interface SALViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UITextField *uniqueKeyTextField;

- (IBAction)showQuickTutorial:(id)sender;

- (IBAction)showHardCodedTutorial:(id)sender;

@end

@implementation SALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.titleTextField becomeFirstResponder];
}

- (IBAction)showQuickTutorial:(id)sender
{
    if (![self validateTextFields]) {
        [[[UIAlertView alloc] initWithTitle:@"All text fields need to be filled" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];

        return;
    }
    
    [self.view endEditing:YES];
    
    BOOL needsToShow = [SALQuickTutorialViewController showIfNeededForKey:self.uniqueKeyTextField.text title:self.titleTextField.text message:self.messageTextField.text image:[UIImage imageNamed:@"QuickTutorialExampleImage"]];
    
    if (!needsToShow) {
        [self alreadyShownWithUniqueKey:self.uniqueKeyTextField.text];
    }
}

- (IBAction)showHardCodedTutorial:(id)sender
{
    [self.view endEditing:YES];
    
    BOOL needsToShow = [SALQuickTutorialViewController showIfNeededForKey:SALProvidedBySAQuickTutorialKey title:@"SALQuickTutorialViewController" message:@"Provided by the Seeking Alpha iOS team. Enjoy! Pull requests are welcome" image:[UIImage imageNamed:@"QuickTutorialExampleImage"]];
    
    if (!needsToShow) {
        [self alreadyShownWithUniqueKey:SALProvidedBySAQuickTutorialKey];
    }
}

- (void)alreadyShownWithUniqueKey:(NSString *)uniqueKey
{
    [[[UIAlertView alloc] initWithTitle:@"SALQuickTutorialViewController shows only once per key!" message:[NSString stringWithFormat:@"The key %@ was already used before", uniqueKey] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (BOOL)validateTextFields
{
    for (UITextField *textField in @[self.titleTextField, self.messageTextField, self.uniqueKeyTextField]) {
        if ([textField.text length] == 0) {
            return NO;
        }
    }
    
    return YES;
}
@end
