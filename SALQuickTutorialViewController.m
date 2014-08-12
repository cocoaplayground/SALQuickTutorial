//
//  SALQuickTutorialViewController.m
//  SALQuickTutorial
//
//  Created by Natan Rolnik on 8/12/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "SALQuickTutorialViewController.h"

@interface SALQuickTutorialViewController ()

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) UIImage *image;

@end

@implementation SALQuickTutorialViewController

#pragma mark - Convenience methods

+ (BOOL)showIfNeededForKey:(NSString *)uniqueKey title:(NSString *)title message:(NSString *)message image:(UIImage *)image
{
    return [self showIfNeededForKey:uniqueKey title:title message:message image:image transitionStyle:MZFormSheetTransitionStyleFade];
}

+ (BOOL)showIfNeededForKey:(NSString *)uniqueKey title:(NSString *)title message:(NSString *)message image:(UIImage *)image transitionStyle:(MZFormSheetTransitionStyle)transitionStyle
{
    if (![self needsToShowForKey:uniqueKey]) {
        return NO;
    }
    
    SALQuickTutorialViewController *quickTutorialViewController = [[self alloc] initWithTitle:title message:message image:image];
    MZFormSheetController *formSheetController = [SALQuickTutorialViewController formSheetControllerWithQuickTutorialViewController:quickTutorialViewController];
    formSheetController.transitionStyle = transitionStyle;
    
    [quickTutorialViewController showInFormSheetController:formSheetController];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:uniqueKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (BOOL)needsToShowForKey:(NSString *)uniqueKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:uniqueKey] == nil;
}

+ (MZFormSheetController *)formSheetControllerWithQuickTutorialViewController:(SALQuickTutorialViewController *)quickTutorialViewController
{
    MZFormSheetController *formSheetController = [[MZFormSheetController alloc] initWithViewController:quickTutorialViewController];
    formSheetController.shouldDismissOnBackgroundViewTap = YES;
    formSheetController.transitionStyle = MZFormSheetTransitionStyleFade;
    formSheetController.cornerRadius = 8.0;
    formSheetController.shouldCenterVertically = YES;
    formSheetController.presentedFormSheetSize = quickTutorialViewController.view.frame.size;
    formSheetController.shadowRadius = 3.0;
    formSheetController.shadowOpacity = 0.25;
    
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:quickTutorialViewController action:@selector(dismiss)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
    [formSheetController.view addGestureRecognizer:swipeGestureRecognizer];
    
    return formSheetController;
}

#pragma mark - SALQuickTutorialViewController creation

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message image:(UIImage *)image
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    
    if (!self) {
        return nil;
    }
    
    self.title = title;
    self.message = message;
    self.image = image;
    
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"SALQuickTutorialViewController must be initialized with initWithTitle:message:image:" userInfo:nil];
}

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = self.title;
    self.messageLabel.text = self.message;
    self.imageView.image = self.image;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - presenting the tutorial

- (void)show
{
    MZFormSheetController *formSheetController = [SALQuickTutorialViewController formSheetControllerWithQuickTutorialViewController:self];
    
    [self showInFormSheetController:formSheetController];
}

- (void)showInFormSheetController:(MZFormSheetController *)formSheetController
{
    NSAssert(formSheetController != nil, @"In order to show a SALQuickTutorialViewController, you must provide a formSheetController");
    NSAssert([formSheetController isKindOfClass:[MZFormSheetController class]], @"In order to show a SALQuickTutorialViewController, you must provide a MZFormSheetController object");
    
    [formSheetController presentAnimated:YES completionHandler:nil];
}

- (void)dismiss
{
    [self.formSheetController dismissAnimated:YES completionHandler:nil];
}

@end
