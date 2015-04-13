//
//  NotesTableViewController.m
//  NoteApp
//
//  Created by Val on 9/04/2015.
//  Copyright (c) 2015 CodeCutters. All rights reserved.
//

#import "NotesTableViewController.h"
#import "EditNoteViewController.h"

@interface NotesTableViewController ()
@property (nonatomic, strong) NSArray *notes;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation NotesTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadNotes];
    [self.tableView reloadData];
}

- (void)loadNotes {
    NSURL *url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSArray *allNoteURLs = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsSubdirectoryDescendants error:nil];
    self.notes = [allNoteURLs sortedArrayUsingComparator:^NSComparisonResult (NSURL *obj1, NSURL *obj2) {
        NSDate *obj1Date = [self dateFromURL:obj1];
        NSDate *obj2Date = [self dateFromURL:obj2];
        return [obj2Date compare:obj1Date];
    }];
}

- (NSDate *)dateFromURL:(NSURL *)url {
    NSDictionary *noteAttributed = [[NSFileManager defaultManager] attributesOfItemAtPath:url.path error:nil];
    return (NSDate *)[noteAttributed objectForKey:NSFileModificationDate];
}

- (IBAction)addNewNoteTapped:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditNoteViewController *newNoteController = [mainStoryboard instantiateViewControllerWithIdentifier:@"EditNoteViewController"];
    [self.navigationController pushViewController:newNoteController animated:YES];
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        _dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    
    return _dateFormatter;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    NSURL *noteURL = [self.notes objectAtIndex:indexPath.row];
    NSString *noteText = noteURL.lastPathComponent.stringByDeletingPathExtension;
    cell.textLabel.text = noteText;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Modified: %@", [self.dateFormatter stringFromDate:[self dateFromURL:noteURL]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *noteURL = [self.notes objectAtIndex:indexPath.row];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditNoteViewController *editNoteController = [mainStoryboard instantiateViewControllerWithIdentifier:@"EditNoteViewController"];
    editNoteController.noteURL = noteURL;
    [self.navigationController pushViewController:editNoteController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *noteURL = [self.notes objectAtIndex:indexPath.row];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager removeItemAtURL:noteURL error:nil]) {
        NSMutableArray *notes = [self.notes mutableCopy];
        [notes removeObjectAtIndex:indexPath.row];
        self.notes = notes.copy;
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
