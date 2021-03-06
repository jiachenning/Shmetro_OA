//
//  IPhone_TodoDetailApproveViewController.h
//  ShmetroOA
//
//  Created by caven shen on 11/15/12.
//
//

#import <UIKit/UIKit.h>
#import "ShmetroOADelegate.h"
#import "TodoInfo.h"
@interface IPhone_TodoDetailApproveViewController : UIViewController<DetailViewControllerDelegate>
@property (nonatomic, assign) id<TabbarViewControllerDelegate> tabbarDelegate;
@property (nonatomic, assign) id<DetailViewControllerDelegate> detailViewControllerDelegate;
@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,retain) TodoInfo *todoInfo;
- (IBAction)action_back:(id)sender;
- (IBAction)action_process:(id)sender;
-(id)init:(TodoInfo *)todoInfoObj;
@end
