//
//  ViewController.m
//  NoteApp
//
//  Created by Val on 8/04/2015.
//  Copyright (c) 2015 CodeCutters. All rights reserved.
//

#import "EditNoteViewController.h"

@interface EditNoteViewController ()
@property (nonatomic, strong) NSString *text;
@end

@implementation EditNoteViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setNoteURL:(NSURL *)noteURL {
    _noteURL = noteURL;
    
    NSData *data = [NSData dataWithContentsOfURL:_noteURL];
    if (data) {
        self.title = [_noteURL.lastPathComponent stringByDeletingPathExtension];
        
        NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.text = text;
    }
    else {
        self.title = @"New Note";
    }
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.textView.text = self.text;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSValue *frameValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [frameValue CGRectValue];
    frame = [self.view convertRect:frame fromView:nil];
    
    UIEdgeInsets contentInset = self.textView.contentInset;
    CGFloat difference = CGRectGetMaxY(self.textView.frame) - CGRectGetMinY(frame);
    if (difference > 0)
        contentInset.bottom = difference;
    self.textView.contentInset = contentInset;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInset = self.textView.contentInset;
    contentInset.bottom = 0.0;
    self.textView.contentInset = contentInset;
}

#pragma mark - Saving

- (IBAction)saveNote:(id)sender {
    self.text = self.textView.text;
    
    if (self.noteURL) {
        if ([self saveNote]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        [self promptUserForNewNoteSave];
    }
}

- (void)promptUserForNewNoteSave {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Save" message:@"Enter a name for your note" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = @"My New Note";
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = alertController.textFields[0];
        NSString *name = textField.text;
        if (!name.length) {
            [self promptUserForNewNoteSave];
            return;
        }
        
        NSURL *url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        url = [url URLByAppendingPathComponent:name];
        url = [url URLByAppendingPathExtension:@"txt"];
        self.noteURL = url;
        
        if ([self saveNote]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOOL)saveNote {
    if (!self.text) return YES;
    
    BOOL saved = NO;
    if (self.noteURL) {
        NSData *data = [self.text dataUsingEncoding:NSUTF8StringEncoding];
        saved = [data writeToURL:self.noteURL atomically:YES];
        if (saved) {
            NSLog(@"Saved to existing url %@", self.noteURL);
        }
        else {
            NSLog(@"Not saved to %@", self.noteURL);
        }
    }
    else {
        NSLog(@"No URL to save to");
    }
    return saved;
}

#pragma mark - Other

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
