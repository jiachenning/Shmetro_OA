//
//  IPad_MeetingDetailInfoViewController.m
//  ShmetroOA
//
//  Created by gisteam on 6/21/13.
//
//

#import "IPad_MeetingDetailInfoViewController.h"
#import "TodoDetailTableviewCell.h"
#import "MeetingDao.h"
#import "DateUtil.h"

@interface IPad_MeetingDetailInfoViewController ()

@end

@implementation IPad_MeetingDetailInfoViewController
@synthesize meetingInfo;
-(id)init:(MeetingInfo *)meetinginfo{
    self = [super init];
    if (self) {
        self.meetingInfo = meetinginfo;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    MeetingDao *dao = [[MeetingDao alloc]init];
    MeetingRoomInfo *meetingRoomInfo = [dao getMeetingRoomInfoByMrid:self.meetingInfo.address];
    [dao release];
    [self.meetingInfo setAddress:meetingRoomInfo.name];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)action_back:(id)sender{
    [self.view removeFromSuperview];
}
#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger *row = [indexPath row];
    NSString *cellIdentifier=@"meetingInfoDetailCellIdentifier";
    TodoDetailTableviewCell *cell = (TodoDetailTableviewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[[TodoDetailTableviewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
    }
    
    int int_row = row;
    switch (int_row) {
        case 0:
            [cell.lab_name setText:@"会议标题"];
            [cell.lab_value setText:[self.meetingInfo title]];
            break;
            
        case 1:
            [cell.lab_name setText:@"开始日期"];
            [cell.lab_value setText:[DateUtil convertNumberToString:[self.meetingInfo startDate]]];
            break;
            
        case 2:
            [cell.lab_name setText:@"开始时间"];
            [cell.lab_value setText:[self.meetingInfo startTime]];
            break;
            
        case 3:
            [cell.lab_name setText:@"结束时间"];
            [cell.lab_value setText:[self.meetingInfo endTime]];
            break;
            
        case 4:
            [cell.lab_name setText:@"会议地点"];
            [cell.lab_value setText:[self.meetingInfo address]];
            break;
            
        case 5:
            [cell.lab_name setText:@"会议主持人"];
            [cell.lab_value setText:[self.meetingInfo compere]];
            break;
            
        case 6:
            [cell.lab_name setText:@"会议参与人（集团内部）"];
            [cell.lab_value setText:[self.meetingInfo present]];
            break;
            
        case 7:
            [cell.lab_name setText:@"会议参与人（集团外部）"];
            [cell.lab_value setText:[self.meetingInfo presentOther]];
            break;
            
        case 8:
            [cell.lab_name setText:@"会议议题"];
            [cell.lab_value setText:[self.meetingInfo topic]];
            break;
            
        case 9:
            [cell.lab_name setText:@"会议参与部门（集团内部）"];
            [cell.lab_value setText:[self.meetingInfo dept]];
            break;
            
        case 10:
            [cell.lab_name setText:@"备注"];
            [cell.lab_value setText:[self.meetingInfo memo]];
            break;
        default:
            break;
    }
    [cell.lab_name setFont:[UIFont boldSystemFontOfSize:15]];
    CGSize theStringSize;
    theStringSize = [cell.lab_value.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(610, MAXFLOAT) lineBreakMode:UILineBreakModeClip];
    CGFloat  resp =  theStringSize.height<23?50: (27 + theStringSize.height);
    [cell setFrame:CGRectMake(0, 0, 879, resp)];
    [cell.contentView setFrame:CGRectMake(0, 0, 879, resp)];
    [cell.lab_name setFrame:CGRectMake(10, 0, 185, resp)];
    [cell.lab_value setFrame:CGRectMake(259, 0, 610, resp)];
    [cell.img_h setFrame:CGRectMake(7, resp -1, 864, 2)];
    [cell.img_v setFrame:CGRectMake(200, 0, 1, resp)];
    return cell;
}

#pragma mark -UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = [indexPath row];
    CGFloat resp = 0.0;
    NSString *value;
    switch (row) {
        case 0:
            value = [self.meetingInfo title];
            break;
            
        case 1:
            value =[DateUtil convertNumberToString:[self.meetingInfo startDate]];
            break;
            
        case 2:
            value = [self.meetingInfo startTime];
            break;
            
        case 3:
            value = [self.meetingInfo endTime];
            break;
            
        case 4:
            value = [self.meetingInfo address];
            break;
            
        case 5:
            value = [self.meetingInfo compere];
            break;
            
        case 6:
            value = [self.meetingInfo present];
            break;
            
        case 7:
            value = [self.meetingInfo presentOther];
            break;
            
        case 8:
            value = [self.meetingInfo topic];
            break;
            
        case 9:
            value = [self.meetingInfo dept];
            break;
            
        case 10:
            value = [self.meetingInfo memo];
            break;
            
        default:
            value =@"";
            break;
    }
    if (value==nil) {
        value = @" ";
    }

    CGSize theStringSize;
    theStringSize = [value sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(610, MAXFLOAT) lineBreakMode:UILineBreakModeClip];
    resp = 27 + theStringSize.height;
    
    return resp<50?50:resp;
}

@end
