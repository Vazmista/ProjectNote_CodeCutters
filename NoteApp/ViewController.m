//
//  ViewController.m
//  NoteApp
//
//  Created by Val on 8/04/2015.
//  Copyright (c) 2015 CodeCutters. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textView.text = self.bodyText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBodyText:(NSString *)bodyText
{
    _bodyText = bodyText;
    self.textView.text = _bodyText;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSValue *frameValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [frameValue CGRectValue];
    frame = [self.view convertRect:frame fromView:nil];
    
    UIEdgeInsets contentInset = self.textView.contentInset;
    CGFloat difference = CGRectGetMaxY(self.textView.frame) - CGRectGetMinY(frame);
    if (difference > 0) {
        contentInset.bottom = difference;
    }
    self.textView.contentInset = contentInset;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets contentInset = self.textView.contentInset;
    contentInset.bottom = 0.0;
    self.textView.contentInset = contentInset;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    [self keyboardWillShow:notification];
}

- (IBAction)saveDocument:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Save" message:@"Enter a name for your note" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.keyboardType = UIKeyboardType
        textField.text = self.title;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = alertController.textFields[0];
        NSString *name = textField.text;
        if (!name) {
            return;
        }
        
        NSURL *url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        url = [url URLByAppendingPathComponent:name];
        url = [url URLByAppendingPathExtension:@"txt"];
        
        NSData *data = [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
        if ([data writeToURL:url atomically:YES]) {
            NSLog(@"Saved to %@", url);
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            NSLog(@"Not saved to %@", url);
        }
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
