/**
 * @file EventViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles creation of new events and fetching of existing events from the server. The class will be able to present a number of events in the proximity of the user and the photos attached to a single event, when selected from the list of events.
 */

#import "EventViewController.h"
#import "PhotoCollectionViewController.h"
#import "NetworkDriver.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController
@synthesize events;
@synthesize tableView;
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)unused numberOfRowsInSection:(NSInteger)section {
    return [events count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)unused cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Event *event = [events objectAtIndex: [indexPath row]];
    cell.textLabel.text = event.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath  *)indexPath {
    [self selectEvent];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"eventListToCollection"])
    {
        NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
        Event *temp = [events objectAtIndex: [indexPath row]];
        PhotoCollectionViewController *vs = [segue destinationViewController];
        vs.event=temp;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self requestEvents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    //self.view.layer.shadowOpacity = 0.75f;
    //self.view.layer.shadowRadius = 10.0f;
    //self.view.layer.shadowColor = [UIColor blackColor].CGColor;

    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void) requestEvents
{
  events = [NetworkDriver regEvents];
}
- (void) selectEvent
{
    [self performSegueWithIdentifier:@"eventListToCollection" sender:self];
}
- (void) showEvent
{
    
}
- (void) showEvents
{
    
}

@end
