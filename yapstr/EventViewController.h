/**
 * @file EventViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles fetching existing events from the server. The class will be able to present a number of events in the proximity of the user and the photos attached to a single event, when selected from the list of events.
 */

#import <UIKit/UIKit.h>

@interface EventViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;
}
@property (strong) NSArray *events;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
- (void) requestEvents;
- (void) selectEvent;
- (void) showEvent;
- (void) showEvents;

@end
