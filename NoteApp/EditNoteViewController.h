//
//  ViewController.h
//  NoteApp
//
//  Created by Val on 8/04/2015.
//  Copyright (c) 2015 CodeCutters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditNoteViewController : UIViewController
@property (nonatomic, strong) NSURL *noteURL;
@property (nonatomic, weak) IBOutlet UITextView *textView;
@end

