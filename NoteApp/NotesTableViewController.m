//
//  NotesTableViewController.m
//  NoteApp
//
//  Created by Val on 9/04/2015.
//  Copyright (c) 2015 CodeCutters. All rights reserved.
//

#import "NotesTableViewController.h"
#import "ViewController.h"

@interface NotesTableViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation NotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newNote:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData
{
    NSURL *url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    NSArray *data = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsSubdirectoryDescendants error:nil];
    
    self.data = [data sortedArrayUsingComparator:^NSComparisonResult(NSURL *obj1, NSURL *obj2) {
        NSDate *obj1Date = [self dateFromURL:obj1];
        NSDate *obj2Date = [self dateFromURL:obj2];
        
        return [obj2Date compare:obj1Date];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

NSDateFormatter *TimeDateFormatter()
{
    static NSDateFormatter *TimeDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TimeDateFormatter = [[NSDateFormatter alloc] init];
        TimeDateFormatter.dateStyle = NSDateFormatterMediumStyle;
        TimeDateFormatter.timeStyle = NSDateFormatterShortStyle;
//        [TimeDateFormatter setDateFormat:@"HH':'mm':'ss"];
//        [TimeDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    });
    
    return TimeDateFormatter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"defaultCell"];
    }
    
    NSURL *currentNoteURL = [self.data objectAtIndex:indexPath.row];
    NSString *noteText = [self nameFromURL:currentNoteURL];
    
    cell.textLabel.text = noteText;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Modified: %@", [TimeDateFormatter() stringFromDate:[self dateFromURL:currentNoteURL]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *newNoteController = [storyBoard instantiateViewControllerWithIdentifier:@"NoteViewController"];
    
    NSURL *currentNoteURL = [self.data objectAtIndex:indexPath.row];
    
    newNoteController.title = [self nameFromURL:currentNoteURL];
    newNoteController.bodyText = [NSString stringWithContentsOfURL:currentNoteURL encoding:NSUTF8StringEncoding error:nil];

    
    [self.navigationController pushViewController:newNoteController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)nameFromURL:(NSURL *)url
{
    NSArray *componentArray = [url.path componentsSeparatedByString:@"/"];
    NSString *name = [componentArray lastObject];
    
    return [name stringByReplacingOccurrencesOfString:@".txt" withString:@""];
}

- (NSDate *)dateFromURL:(NSURL *)url
{
    NSDictionary *noteAttributed = [[NSFileManager defaultManager] attributesOfItemAtPath:url.path error:nil];
    
    return (NSDate *)[noteAttributed objectForKey:NSFileModificationDate];
}

- (void)newNote:(id)sender
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *newNoteController = [storyBoard instantiateViewControllerWithIdentifier:@"NoteViewController"];
    
    [self.navigationController pushViewController:newNoteController animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
