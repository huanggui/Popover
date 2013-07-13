//
//  ViewController.m
//  popover
//
//  Created by Oliver Rickard on 21/08/2012.
//  Copyright (c) 2012 Oliver Rickard. All rights reserved.
//

#import "ViewController.h"
#import "PopoverView.h"
#import "OCDaysView.h"
#import <QuartzCore/QuartzCore.h> //This is just for the daysView where I call "daysView.layer" not necessary normally.

#define kStringArray [NSArray arrayWithObjects:@"YES", @"NO", nil]
#define kImageArray [NSArray arrayWithObjects:[UIImage imageNamed:@"success"], [UIImage imageNamed:@"error"], nil]

@interface ViewController ()

@end

@implementation ViewController



#pragma mark - Setup Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:[tap autorelease]];
    
    //Create a label centered on the screen
    UILabel *tapAnywhereLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 200.f*0.5f, CGRectGetMidY(self.view.bounds) - 30.f*0.5f, 200.f, 30.f)];
    tapAnywhereLabel.text = @"Tap Anywhere";
    tapAnywhereLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:[tapAnywhereLabel autorelease]];
}



#pragma mark - User Interaction Methods

#pragma mark EXAMPLE CODE IS HERE

- (void)tapped:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.view];
    
    //Here are a couple of different options for how to display the Popover
    
//    [PopoverView showPopoverAtPoint:point inView:self.view withText:@"This is a very long popover box.  As you can see, it goes to multiple lines in size." delegate:self]; //Show text wrapping popover with long string
    
//    [PopoverView showPopoverAtPoint:point inView:self.view withTitle:@"This is a title" withText:@"This is text" delegate:self]; //Show text with title
    
//    [PopoverView showPopoverAtPoint:point inView:self.view withStringArray:kStringArray delegate:self]; //Show the string array defined at top of this file
    
//    [PopoverView showPopoverAtPoint:point inView:self.view withTitle:@"Was this helpful?" withStringArray:kStringArray delegate:self]; //Show string array defined at top of this file with title.
    
//    [PopoverView showPopoverAtPoint:point inView:self.view withStringArray:kStringArray withImageArray:kImageArray delegate:self];
    
    [PopoverView showPopoverAtPoint:point inView:self.view withTitle:@"DEBUG" withStringArray:kStringArray withImageArray:kImageArray delegate:self];
    
//    //Here's a little bit more advanced sample.  I create a custom view, and hand it off to the PopoverView to display for me.  I round the corners
//    OCDaysView *daysView = [[OCDaysView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
//    [daysView setMonth:10];
//    [daysView setYear:2012];ßß
//    daysView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.f]; //Give it a background color
//    daysView.layer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.f].CGColor; //Add a border
//    daysView.layer.borderWidth = 0.5f; //One retina pixel width
//    daysView.layer.cornerRadius = 4.f;
//    daysView.layer.masksToBounds = YES;
    
//    pv = [PopoverView showPopoverAtPoint:point inView:self.view withContentView:[daysView autorelease] delegate:self]; //Show calendar with no title
//    [PopoverView showPopoverAtPoint:point inView:self.view withTitle:@"October 2012" withContentView:[daysView autorelease] delegate:self]; //Show calendar with title
//
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    pv = [[PopoverView showPopoverAtPoint:point inView:self.view withContentView:tableView delegate:self] retain];
}



#pragma mark - DEMO - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"text";
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.f];
    
    return [cell autorelease];
}



#pragma mark - PopoverViewDelegate Methods

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%s item:%d", __PRETTY_FUNCTION__, index);//__PRETTY_FUNCTION__返回当前执行函数的类名和函数名
    
    //Figure out which string was selected, store in "string"
    NSString *string = [kStringArray objectAtIndex:index];
    
    //Show a success image, with the string from the array

    [popoverView showImage:[UIImage imageNamed:[string isEqualToString:@"YES"] ? @"success" : @"error"] withMessage:string];
    
    //Dismiss the PopoverView after 0.5 seconds
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}



#pragma mark - UIViewController Methods

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if(pv) {
        [pv animateRotationToNewPoint:CGPointMake(self.view.frame.size.width*0.5f, self.view.frame.size.height*0.5f) inView:self.view withDuration:duration];
    }
}

@end
