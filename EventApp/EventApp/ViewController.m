//
//  ViewController.m
//  EventApp
//
//  Created by Rajeev Dubey on 02/09/15.
//  Copyright (c) 2015 GrXtreme Technologies. All rights reserved.
//


#import "Header.h"

@interface ViewController ()<UIActionSheetDelegate>
@property (nonatomic, weak) IBOutlet UILabel *dontforgetMessageLabel;
@property (nonatomic, weak) IBOutlet UILabel *lessonDetailLabel;
@property (nonatomic, weak) IBOutlet UILabel *afterSchoolDetailLabel;
@property (nonatomic, weak) IBOutlet UILabel *finishedSchoolLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set screen title
    [self setTitle:@"Max Charles"];
    
    // adding navigation bar buttons
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuicon"] style:UIBarButtonItemStylePlain target:self action:@selector(menuAction)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"alarmicon"] style:UIBarButtonItemStylePlain target:self action:@selector(alarmAction)];
    
    // update class info from plist
    [self getDataFromDatabase];
}



#pragma mark- Get Data from plist
// set screen data
- (void)getDataFromDatabase
{
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
    
    NSInteger currentMonth= [components month]; //gives you month
    NSInteger currentDay= [components day]; //gives you day
    //NSInteger year= [components year]; // gives you year
    
    NSString *path = [[NSBundle mainBundle] pathForResource:kDatabaseName ofType:kDatabaseType];
    NSArray *dataList = [[NSArray alloc] initWithContentsOfFile:path];
    
    NSString *schoolEndTime = @"";
    NSMutableArray *lessonDetail = [[NSMutableArray alloc] init];
    NSMutableArray *afterSchoolDetail = [[NSMutableArray alloc] init];
    
    for (NSDictionary *record in dataList)
    {
        NSString *startDateString = [record valueForKey:kDateStart];
        if (startDateString.length>0)
        {
            NSInteger dayFromDB = [[[startDateString componentsSeparatedByString:@"/"] objectAtIndex:0] integerValue];
            NSInteger monthFromDB = [[[startDateString componentsSeparatedByString:@"/"] objectAtIndex:1] integerValue];
            if (dayFromDB == currentDay && monthFromDB == currentMonth)
            {
                if ([[record valueForKey:kType] isEqualToString:@"Lesson"])
                {
                    [lessonDetail addObject:[record valueForKey:kShortDesc]];
                    
                }
                else
                {
                    NSString *type = [NSString stringWithFormat:@"%@",[[record valueForKey:kType] lowercaseString]];
                    NSString *msg = [NSString stringWithFormat:@"%@ %@",[record valueForKey:kShortDesc],type];
                    [afterSchoolDetail addObject:msg];
                    schoolEndTime = [NSString stringWithFormat:@"%@",[record valueForKey:kTimeStart]];

                }
            }
            else if(currentDay+1 == dayFromDB && currentMonth == monthFromDB)
            {
                if ([[record valueForKey:kDontForgetView] isEqualToString:@"Yes"])
                {
                    [self.dontforgetMessageLabel setText:[NSString stringWithFormat:@"%@ tomorrow",[record valueForKey:kLongDesc]]];
                }
            }
        }
        
    }
    
    // update lesson detail message
    NSString *lessonText = [NSString stringWithFormat:@"%@",[lessonDetail componentsJoinedByString:@","]];
    [self.lessonDetailLabel setText:lessonText];
    
    // update after school detail message
    NSString *afterSchoolText = [NSString stringWithFormat:@"%@",[afterSchoolDetail componentsJoinedByString:@","]];
    [self.afterSchoolDetailLabel setText:afterSchoolText];
    
    // update finish school time
    [self.finishedSchoolLabel setText:schoolEndTime];
    
}


#pragma mark- Button Action

// menu button
- (void)menuAction
{
    
}

// alarm button
- (void)alarmAction
{
    
}

// show more info by swipe
- (IBAction)showMoreInfo:(id)sender
{
    UIStoryboard *storyboard = storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShowMoreInfoVC  *moreInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"ShowMoreInfoVC"];
    [self.navigationController pushViewController:moreInfoVC animated:YES];
}

// open phone list
- (IBAction)callAction:(id)sender
{
    UIActionSheet *phoneListActionsheet = [[UIActionSheet alloc] initWithTitle:@"Select Your Contact" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"+44-(0)1224-XXXX-XXXX", nil];
    [phoneListActionsheet setTag:1];
    [phoneListActionsheet showInView:self.view];
}


// open email list
- (IBAction)mailAction:(id)sender
{
    UIActionSheet *emailListActionsheet = [[UIActionSheet alloc] initWithTitle:@"Select Your Contact" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"test@gmail.com", nil];
    [emailListActionsheet setTag:2];
    [emailListActionsheet showInView:self.view];

}

// handle the user's choice
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet tag] == 1)
    {
        NSLog(@"Your choice from phone list : %@",[actionSheet buttonTitleAtIndex:buttonIndex]);
    }
    else if ([actionSheet tag] == 2)
    {
        NSLog(@"Your choice from email list : %@",[actionSheet buttonTitleAtIndex:buttonIndex]);
    }
}



#pragma mark- 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
