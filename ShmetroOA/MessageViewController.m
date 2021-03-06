//
//  MessageViewController.m
//  ShmetroOA
//
//  Created by gisteam on 6/17/13.
//
//

#import "MessageViewController.h"
#import "MessageDao.h"
#import "MessageDetailInfo.h"
#import "TotoListTableViewCell.h"
#import "STOService.h"
#import "RefreshTableHeaderView.h"
#import "RefreshTableFooterView.h"
#import "AppDelegate.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
@synthesize messageArray,mainViewDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
            [super initWithNibName:@"MessageViewController_iPad" bundle:nil];
        }
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

}

-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate showLoadingWithText:@"正在载入..." inView: self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.pageNumber = 1;
        NSString *page = [NSString stringWithFormat:@"%d",self.pageNumber];
        STOService *service = [[STOService alloc]init];
        self.messageArray =  [service searchMessageListFromOffset:page WithLimit:@"10"];
        [service release];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.messageArray == nil || [self.messageArray count]<1) {
                
            }else{
                [self.tableView reloadData];
            }
            [appDelegate closeLoading];
        });
    });
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"RefreshTableHeaderView" owner:self options:nil];
    RefreshTableHeaderView *refreshHeaderView = (RefreshTableHeaderView *)[nib objectAtIndex:0];
    self.headerView = refreshHeaderView;
    
    nib = [[NSBundle mainBundle]loadNibNamed:@"RefreshTableFooterView" owner:self options:nil];
    RefreshTableFooterView *refreshFooterView = (RefreshTableFooterView *)[nib objectAtIndex:0];
    self.footerView =  refreshFooterView;

    
    // Do any additional setup after loading the view from its nib.
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setFrame:CGRectMake(0, 46, 280, 702)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [messageArray release];
    [super dealloc];
}

#pragma mark - Pull to Refresh

- (void)pinHeaderView {
    [super pinHeaderView];
    
    // do custom handling for the header view
    RefreshTableHeaderView *hv = (RefreshTableHeaderView *)self.headerView;
    [hv.activityIndicator startAnimating];
    hv.title.text = @"加载中...";
}

- (void)unpinHeaderView {
    [super unpinHeaderView];
    
    // do custom handling for the header view
    [[(RefreshTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}

- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    RefreshTableHeaderView *hv = (RefreshTableHeaderView *)self.headerView;
    if (willRefreshOnRelease)
        hv.title.text = @"松开刷新...";
    else
        hv.title.text = @"下拉可以刷新...";
}

- (BOOL) refresh
{
    if (![super refresh])
        return NO;
    
    // Do your async call here
    // This is just a dummy data loader:
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:2.0];
    // See -addItemsOnTop for more info on how to finish loading
    return YES;
}

- (void)refreshData {
    
    self.pageNumber = 1;
    NSString *page = [NSString stringWithFormat:@"%d",self.pageNumber];
    STOService *service = [[STOService alloc]init];
    self.messageArray =  [service searchMessageListFromOffset:page WithLimit:@"10"];
    [service release];
    
    [self.tableView reloadData];
    [self refreshCompleted];
}


#pragma mark - Load More
- (void) willBeginLoadingMore
{
    RefreshTableFooterView *fv = (RefreshTableFooterView *)self.footerView;
    [fv.activityIndicator startAnimating];
}

- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    RefreshTableFooterView *fv = (RefreshTableFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (!self.canLoadMore) {
        // Do something if there are no more items to load
        
        // We can hide the footerView by: [self setFooterViewVisibility:NO];
        
        // Just show a textual info that there are no more items to load
        fv.infoLabel.hidden = NO;
    }
}

- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    
    // Do your async loading here
    [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:2.0];
    // See -addItemsOnBottom for more info on what to do after loading more items
    
    return YES;
}

- (void)loadMoreData {
    
    STOService *service = [[STOService alloc]init];
    self.pageNumber = self.pageNumber * 10 + 1;
    NSString *page = [NSString stringWithFormat:@"%d",self.pageNumber];
    NSMutableArray *newData =  [service searchMessageListFromOffset:page WithLimit:@"10"];
    [service release];
    int count = [newData count];
    if (count>0) {
        if (self.messageArray == nil) {
            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
            self.messageArray = tempArray;
            [tempArray release];
        }
        for (int i = 0; i< count; i++) {
            MessageDetailInfo *messageDetailInfo = [newData objectAtIndex:i];
            [self.messageArray addObject:messageDetailInfo];
        }
    }
   
    
    
    
    [self.tableView reloadData];
    
//    if (self.messageArray.count > 100)
//        self.canLoadMore = NO; // signal that there won't be any more items to load
//    else
//        self.canLoadMore = YES;
    
    
    
    [self loadMoreCompleted];
}



#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return messageArray ==nil?0:messageArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger *row = [indexPath row];
    static NSString *cellIdentifier = @"MessageTableViewCellIdentifier";
    TotoListTableViewCell *cell = (TotoListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[[TotoListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
    }
    
    MessageDetailInfo *messageDetailInfo = [messageArray objectAtIndex:row];
    [cell.labTitle setText: messageDetailInfo.title];
    [cell.labSubTitle setText: [NSString stringWithFormat:@"发起时间：%@",messageDetailInfo.pubDate]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger *row = [indexPath row];
    MessageDetailInfo *messageDetailInfo = [messageArray objectAtIndex:row];
//    STOService *service = [[STOService alloc]init];
//    messageDetailInfo = [service getMessageDetail:messageDetailInfo.mid App:messageDetailInfo.app];
//    [service release];
    if (mainViewDelegate) {
        [mainViewDelegate viewDetail_iPad:messageDetailInfo];
    }
}

@end
