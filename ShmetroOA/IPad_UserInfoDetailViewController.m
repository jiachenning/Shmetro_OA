//
//  IPad_UserInfoDetailViewController.m
//  ShmetroOA
//
//  Created by gisteam on 6/18/13.
//
//

#import "IPad_UserInfoDetailViewController.h"
#import "UserAccountContext.h"
#import "STOService.h"
#import "StringUtil.h"
#import "UIViewUtil.h"
#import "AppDelegate.h"

@interface IPad_UserInfoDetailViewController ()
-(void)refreshUserInfo:(BOOL)init;

-(void)saveUserInfomation;
-(void)saveUserNichNameAndPassword;

-(BOOL)isValidateEmail:(NSString *)email;
-(BOOL)isValidateTelephone:(NSString *)telephone;
-(BOOL)isValidatePhone:(NSString *)phone;
-(BOOL)isValidatePostcode:(NSString *)postCode;

@end


@implementation IPad_UserInfoDetailViewController
@synthesize userInfo,view_infomation,view_passwordnickname,view_other,view_contact;
@synthesize lblTitle,txtRetire,txtSex,txtZN,btnInfo,btnPassword,btnContact,btnOther,btnSave,btnRefresh;
@synthesize lblLoginName1,lblLoginName2,lblLoginName3,lblLoginName4;
@synthesize txtAddress,txtBirthday,txtBirthplace,txtCaddress,txtCompany,txtCphone;
@synthesize txtCpostcode,txtDegree,txtDept,txtGrade,txtIdCard;
@synthesize txtMajor,txtMobile1,txtMobile2,txtEmail,txtNation,txtPhone;
@synthesize txtPolitical,txtPostcode,txtRemark,txtTitle,txtRank;
@synthesize txtNickName2,txtConfirmPassword,txtNewPassword;

int oldTag;

-(id)init:(UserInfo *)userInfoObj{
    self = [super init];
    
    if (self) {
        self.userInfo = userInfoObj;
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
-(void)viewWillAppear:(BOOL)animated
{
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    oldTag = 1;
    
    [self refreshUserInfo:YES];
        // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && [self.view window] == nil) {
        self.view = nil;
    }
    // Dispose of any resources that can be recreated.
}

/*
-(void)dataPick:(UITextField *)txtFiled DataArray:(NSArray *)dataArr{
    self.selectedTextFiled = txtFiled;
    UIViewController *sortViewController = [[[UIViewController alloc] init] autorelease];
    [sortViewController.view setBackgroundColor:[UIColor blackColor]];
    self.dataPickView = [[[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)] autorelease];
    [sortViewController.view addSubview:dataPickView];
    
    UIButton *btnOK = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnOK setFrame:CGRectMake(0, 216, 160, 44)];
    [btnOK setTitle:@"确认" forState:UIControlStateNormal];
    btnOK.tag = 1;
    UIButton *btnNO = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnNO setFrame:CGRectMake(160, 216, 160, 44)];
    [btnNO setTitle:@"取消" forState:UIControlStateNormal];
    btnNO.tag = 2;
    [btnOK addTarget:self action:@selector(action_datapickerSelected:) forControlEvents:UIControlEventTouchUpInside];
    [btnNO addTarget:self action:@selector(action_datapickerSelected:) forControlEvents:UIControlEventTouchUpInside];
    [sortViewController.view addSubview:btnNO];
    [sortViewController.view addSubview:btnOK];
    
    dataPickView.delegate = self;
    dataPickView.dataSource = self;
    dataPickView.showsSelectionIndicator = YES;
    
    sortViewController.contentSizeForViewInPopover = CGSizeMake(320, 260);
    
    self.sortPopover = [[[UIPopoverController alloc] initWithContentViewController:sortViewController] autorelease];
    [self.sortPopover presentPopoverFromRect:txtFiled.frame inView:self.view_infomation permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)datePick{
    UIViewController *sortViewController = [[[UIViewController alloc] init] autorelease];
    [sortViewController.view setBackgroundColor:[UIColor blackColor]];
    self.birthdayPicker = [[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)] autorelease];
    [self.birthdayPicker setDatePickerMode:UIDatePickerModeDate];
    NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]autorelease];
    [self.birthdayPicker setLocale:locale];
    [sortViewController.view addSubview:birthdayPicker];
    
    UIButton *btnOK = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnOK setFrame:CGRectMake(0, 216, 160, 44)];
    [btnOK setTitle:@"确认" forState:UIControlStateNormal];
    btnOK.tag = 1;
    UIButton *btnNO = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnNO setFrame:CGRectMake(160, 216, 160, 44)];
    [btnNO setTitle:@"取消" forState:UIControlStateNormal];
    btnNO.tag = 2;
    [btnOK addTarget:self action:@selector(action_datepickerSelected:) forControlEvents:UIControlEventTouchUpInside];
    [btnNO addTarget:self action:@selector(action_datepickerSelected:) forControlEvents:UIControlEventTouchUpInside];
    [sortViewController.view addSubview:btnNO];
    [sortViewController.view addSubview:btnOK];
    
    sortViewController.contentSizeForViewInPopover = CGSizeMake(320, 260);
    
    self.sortPopover = [[[UIPopoverController alloc] initWithContentViewController:sortViewController] autorelease];
    [self.sortPopover presentPopoverFromRect:txtBirthday.frame inView:self.view_infomation permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

-(void)action_datapickerSelected:(UIButton *)button{
    if (button.tag == 1) {
       self.selectedTextFiled.text = [self.dataArr objectAtIndex:[self.dataPickView selectedRowInComponent:0]];
    }
    [self.sortPopover dismissPopoverAnimated:YES];
}

-(void)action_datepickerSelected:(UIButton *)button{
    if (button.tag == 1) {
        NSDate *dateSelected = [self.birthdayPicker date];
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init]autorelease];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate =  [dateFormatter stringFromDate:dateSelected];
        txtBirthday.text = strDate;
    }
    [self.sortPopover dismissPopoverAnimated:YES];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  self.dataArr == nil?0:[dataArr count];
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.dataArr objectAtIndex:row];
}
*/

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    int tag = textField.tag;
    switch (tag) {
        case 4: //出生日期
            [self datePick];
            return NO;
            break;
           
//        case 7://政治面貌
//            self.dataArr = [NSMutableArray arrayWithArray:self.politicalArr];
//            [self dataPick:textField DataArray:self.dataArr];
//            return NO;
//            break;
//            
//        case 8://最高学历
//            self.dataArr = [NSMutableArray arrayWithArray:self.degreeArr];
//            [self dataPick:textField DataArray:self.dataArr];
//            return NO;
//            break;
//            
//        case 16://技术等级
//            self.dataArr = [NSMutableArray arrayWithArray:self.gradeArr];
//            [self dataPick:textField DataArray:self.dataArr];
//            return NO;
//            break;
//            
//        case 17://最高职称
//            self.dataArr = [NSMutableArray arrayWithArray:self.titleArr];
//            [self dataPick:textField DataArray:self.dataArr];
//            return NO;
//            break;
//            
//        case 18://技术专业
//            self.dataArr = [NSMutableArray arrayWithArray:self.majorArr];
//            [self dataPick:textField DataArray:self.dataArr];
//            return NO;
//            break;
            
        default:
            break;
    }

    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    int tag = textField.tag;
    switch (tag) {
           
//        case 9://邮政编码
//            if (![self isValidatePhone:textField.text]) {
//                textField.text = [self.userInfo postcode];
//            }
//            break;
            
        case 13://联系电话
            if (![self isValidatePhone:textField.text]) {
                textField.text = [self.userInfo phone];
            }
            break;
            
        case 10://手机号码1
           if (![self isValidateTelephone:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]) {
                textField.text = [self.userInfo mobile1];
            }
            break;
            
        case 12://手机号码2
            if (![self isValidateTelephone:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]) {
                textField.text = [self.userInfo mobile2];
            }
            break;
            
        case 11://电子邮箱
            if (![self isValidateEmail:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]) {
                textField.text = [self.userInfo email];
            }
            break;
            
//        case 21://单位邮编
//            if (![self isValidatePostcode:textField.text]) {
//                textField.text = [self.userInfo cpostcode];
//            }
//            break;
            
        case 24://昵称
//            if (![self checkNickNameUniqueness:textField.text]) {
//                textField.text = [self.userInfo nickName];
//            }
            [self checkNickNameUniqueness:textField.text];
//        case 26://确认密码
//            if (![self checkNickNameUniqueness:textField.text]) {
//                textField.text = [self.userInfo nickName];
//            }
            
        default:
            break;
    }
}


-(BOOL)isValidateTelephone:(NSString *)telephone{
//    NSString * regex =  @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSString * regex =  @"^[1-9]\\d*|0$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValidate = [pred evaluateWithObject:telephone];
    
    if (!isValidate) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return NO;
    }
    return YES;
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:telephone] == YES)
//        || ([regextestcm evaluateWithObject:telephone] == YES)
//        || ([regextestct evaluateWithObject:telephone] == YES)
//        || ([regextestcu evaluateWithObject:telephone] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}

-(BOOL)isValidatePhone:(NSString *)phone{
//   NSString * regex= @"^(([0\\+]\\d{2,3}-)?(0\\d{2,3})-)?(\\d{7,8})(-(\\d{3,}))?$";
    NSString * regex= @"^[1-9]\\d*|0$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValidate = [pred evaluateWithObject:phone];
    
    if (!isValidate) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的联系电话" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return NO;
    }
    return YES;
}

-(BOOL)isValidatePostcode:(NSString *)postCode{
    NSString * regex =  @"^[1-9][0-9]{5}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValidate = [pred evaluateWithObject:postCode];
    
    if (!isValidate) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的邮政编码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return NO;
    }
    return YES;
}

-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValidate = [emailTest evaluateWithObject:email];
    
    if (!isValidate) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的邮箱" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return NO;
    }
    return YES;
}

-(BOOL)checkNickNameUniqueness:(NSString *)nickName{
    __block BOOL isUnique = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STOService *service = [[STOService alloc]init];
        isUnique = [service checkNickName:nickName];
        [service release];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!isUnique) {
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate closeLoading];
                [appDelegate showToast:@"该昵称不可用" hideAfterSecond:2];
                [self.txtNickName2 setText:self.userInfo.nickName];
            }
        });
    });

    return isUnique;
}
/*
-(IBAction)menu_select:(id)sender{
    UIButton *button = sender;
    if (oldTag == button.tag) {
        return;
    }
    switch (button.tag) {
        case 0:
            [self.view bringSubviewToFront:self.btnInfo];
             [UIViewUtil uiviewChange:(UIViewAnimationTransition *)UIViewAnimationTransitionCurlDown SourceView:self.view_passwordnickname DestView:self.view_infomation];
            [self.lblTitle setText:@"个人信息"];
            break;
            
        case 1:
            [self.view bringSubviewToFront:self.btnInfo];
            [UIViewUtil uiviewChange:(UIViewAnimationTransition *)UIViewAnimationTransitionCurlDown SourceView:self.view_passwordnickname DestView:self.view_contact];
            [self.lblTitle setText:@"联系方式"];
            break;
            
        case 2:
            [self.view bringSubviewToFront:self.btnInfo];
            [UIViewUtil uiviewChange:(UIViewAnimationTransition *)UIViewAnimationTransitionCurlDown SourceView:self.view_passwordnickname DestView:self.view_other];
            [self.lblTitle setText:@"其它信息"];
            break;
            
        case 3:
            [self.view bringSubviewToFront:self.btnPassword];
              [UIViewUtil uiviewChange:(UIViewAnimationTransition *)UIViewAnimationTransitionCurlUp SourceView:self.view_infomation DestView:self.view_passwordnickname];
             [self.lblTitle setText:@"昵称和密码修改"];
            break;
            
        default:
            break;
    }
    oldTag = button.tag;
    double delayInSeconds = 0.01;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        switch (button.tag) {
            case 0:{
                [self.view_passwordnickname setHidden:YES];
                [self.scrollView setHidden:NO];
                [self.view_infomation setHidden:NO];
                break;
            }
            case 1:{
                [self.view_passwordnickname setHidden:NO];
                [self.scrollView setHidden:YES];
                [self.view_infomation setHidden:YES];
                break;
            }
            default:
                break;
        }
        
    });

}
*/
-(IBAction)menu_select:(id)sender {
    UIButton *btn = sender;
    switch (btn.tag) {
        case 1:{
            [self.view bringSubviewToFront:self.btnPassword];
            [self.view bringSubviewToFront:self.btnOther];
            [self.view bringSubviewToFront:self.btnContact];
            break;
        }
        case 2:{
            [self.view bringSubviewToFront:self.btnPassword];
            [self.view bringSubviewToFront:self.btnOther];
            [self.view bringSubviewToFront:self.btnInfo];
            break;
        }
        case 3:{
            [self.view bringSubviewToFront:self.btnInfo];
            [self.view bringSubviewToFront:self.btnContact];
            [self.view bringSubviewToFront:self.btnPassword];
            break;
        }
        case 4:{
            [self.view bringSubviewToFront:self.btnInfo];
            [self.view bringSubviewToFront:self.btnContact];
            [self.view bringSubviewToFront:self.btnOther];
            break;
        }
        default:
            break;
    }
    [self.view bringSubviewToFront:sender];
    [self showDetailContent:btn.tag];
}

-(IBAction)saveUserInfoModify:(id)sender{
    if ([self.lblTitle.text isEqualToString:@"联系方式"]) {
        [self saveUserInfomation];
    }else{
        [self saveUserNichNameAndPassword];
    }
}

-(IBAction)refreshData:(id)sender{
    [self refreshUserInfo:NO];
}

-(void)showDetailContent:(int)tag{
    if (oldTag!=tag) {
        UIView *srcView = nil ;
        UIView *destView = nil;
        switch (oldTag) {
            case 1:
                srcView = self.view_infomation;
                break;
            case 2:
                srcView = self.view_contact;
                break;
            case 3:
                srcView = self.view_other;
                break;
            case 4:
                srcView = self.view_passwordnickname;
                break;
            default:
                break;
        }
        switch (tag) {
            case 1:
                destView = self.view_infomation;
                break;
            case 2:
                destView = self.view_contact;
                break;
            case 3:
                destView = self.view_other;
                break;
            case 4:
                destView = self.view_passwordnickname;
                break;
            default:
                break;
        }
        if (oldTag>tag) {
            [UIViewUtil uiviewChange:(UIViewAnimationTransition *)UIViewAnimationTransitionCurlDown SourceView:srcView DestView:destView];
        }else{
            [UIViewUtil uiviewChange:(UIViewAnimationTransition *)UIViewAnimationTransitionCurlUp SourceView:srcView DestView:destView];
        }
        
        oldTag = tag;
        double delayInSeconds = 0.01;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            switch (tag) {
                case 1:{
                    [self.view_infomation setHidden:NO];
                    [self.view_contact setHidden:YES];
                    [self.view_other setHidden:YES];
                    [self.view_passwordnickname setHidden:YES];
                    [btnSave setHidden:YES];
                    [lblTitle setText:@"个人信息"];
                    break;
                }
                case 2:{
                    [self.view_infomation setHidden:YES];
                    [self.view_contact setHidden:NO];
                    [self.view_other setHidden:YES];
                    [self.view_passwordnickname setHidden:YES];
                    [btnSave setHidden:NO];
                     [lblTitle setText:@"联系方式"];
                    break;
                }
                case 3:{
                    [self.view_infomation setHidden:YES];
                    [self.view_contact setHidden:YES];
                    [self.view_other setHidden:NO];
                    [self.view_passwordnickname setHidden:YES];
                    [btnSave setHidden:YES];
                     [lblTitle setText:@"其它信息"];
                    break;
                }
                case 4:{
                    [self.view_infomation setHidden:YES];
                    [self.view_contact setHidden:YES];
                    [self.view_other setHidden:YES];
                    [self.view_passwordnickname setHidden:NO];
                    [btnSave setHidden:NO];
                     [lblTitle setText:@"昵称和密码修改"];
                    break;
                }
                default:
                    break;
            }
        });
    }
}


-(void)refreshUserInfo:(BOOL)init{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (init) {
        [appDelegate showLoadingWithText:@"正在载入..."];
    }else{
        [appDelegate showLoadingWithText:@"正在刷新..."];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STOService *service = [[STOService alloc]init];
        UserInfo * userinfo = [service refreshUserInfo];
        self.userInfo = userinfo;
        [service release];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *name =  [NSString stringWithFormat:@"%@(%@)",self.userInfo.name,self.userInfo.loginName];
            lblLoginName1.text =name;
            lblLoginName2.text = name;
            lblLoginName3.text = name;
            lblLoginName4.text=name;
            txtIdCard.text = [self.userInfo idCard];
            txtNation.text = [self.userInfo nation];
            txtBirthday.text = [self.userInfo birthday];
            txtRank.text = [self.userInfo rank];
            txtTitle.text = [self.userInfo title];
            txtAddress.text = [self.userInfo address];
            txtBirthplace.text=[self.userInfo birthplace];
            txtCaddress.text = [self.userInfo caddress];
            txtCompany.text = [self.userInfo company];
            txtCphone.text = [self.userInfo cphone];
            txtCpostcode.text =[self.userInfo cpostcode];
            txtDegree.text = [self.userInfo degree];
            txtDept.text = [self.userInfo dept];
            txtGrade.text = [self.userInfo grade];
            txtMajor.text = [self.userInfo major];
            txtMobile1.text = [self.userInfo mobile1];
            txtMobile2.text = [self.userInfo mobile2];
            txtEmail.text = [self.userInfo email];
            txtPhone.text = [self.userInfo phone];
            txtPolitical.text = [ self.userInfo political];
            txtPostcode.text = [self.userInfo postcode];
            txtRemark.text = [self.userInfo remark];
            if ([self.userInfo sex]!=nil) {
                txtSex.text = [[self.userInfo sex]isEqualToString:@"1"]?@"男":@"女";
            }
            txtRetire.text = [self.userInfo retire];
            txtZN.text = [self.userInfo household];
            
            txtNickName2.text = [self.userInfo nickName];
            [appDelegate closeLoading];
        });
    });
}
-(void)saveUserInfomation{
    [txtPhone resignFirstResponder];
    [txtMobile1 resignFirstResponder];
    [txtMobile2 resignFirstResponder];
    [txtEmail resignFirstResponder];
    
    NSString *email = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *phone = [txtPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *mobile1 = [txtMobile1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *mobile2 = [txtMobile2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showLoadingWithText:@"正在保存数据......"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STOService *service = [[[STOService alloc]init]autorelease];
        BOOL  isSuccess = [service modifyUserInfo:self.userInfo.uid Email:email Phone:phone Moible1:mobile1 Mobile2:mobile2];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isSuccess) {
                [appDelegate closeLoading];
                [appDelegate showToast:@"修改成功" hideAfterSecond:2];
            }
        });
    });
}

-(void)saveUserNichNameAndPassword{
    [txtNewPassword resignFirstResponder];
    [txtConfirmPassword resignFirstResponder];
    [txtNickName2 resignFirstResponder];
    
    if ([[txtNickName2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]isEqual:@""]) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate closeLoading];
        [appDelegate showToast:@"昵称不能为空" hideAfterSecond:2];
        return;
    }
//    if ([[txtNewPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]isEqual:@""]) {
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [appDelegate closeLoading];
//        [appDelegate showToast:@"新密码不能为空" hideAfterSecond:2];
//        return;
//    }
    if (![txtNewPassword.text isEqual:txtConfirmPassword.text]) {
        txtNewPassword.text=@"";
        txtConfirmPassword.text = @"";
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate closeLoading];
        [appDelegate showToast:@"确认密码与新密码不一致" hideAfterSecond:2];
        return;
    }
    NSString *nickName = [txtNickName2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *newPassword = [StringUtil md5Digest:[txtNewPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    NSString *pass = [txtNewPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *desPass = [StringUtil TripleDES:pass];
    NSString *newPassword = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)desPass, nil, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showLoadingWithText:@"正在保存数据......"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STOService *service = [[[STOService alloc]init]autorelease];
        BOOL isNicknameUnique = YES;
        if (![nickName isEqualToString:self.userInfo.nickName]) {
            isNicknameUnique = [service checkNickName:nickName];
        }
        
        BOOL  isSuccess = NO;
        if (isNicknameUnique) {
            isSuccess = [service modifyUserPasswordAndNick:self.userInfo.uid Password:newPassword Nickname:nickName];
            [self refreshUserInfo:NO];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [appDelegate closeLoading];
            if (!isNicknameUnique) {
                [appDelegate showToast:@"修改失败，昵称需唯一" hideAfterSecond:2];
            }else if(!isSuccess){
                 [appDelegate showToast:@"修改失败，请稍后再试" hideAfterSecond:2];
            }else if(isSuccess){
                [appDelegate showToast:@"修改成功" hideAfterSecond:2];
            }

        });
    });
    
//    STOService *service = [[[STOService alloc]init]autorelease];
//    BOOL isNicknameUnique = [service checkNickName:nickName];
//    if (isNicknameUnique) {
//        isSuccess = [service modifyUserPasswordAndNick:self.userInfo.uid Password:newPassword Nickname:nickName];
//    }else{
//        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"昵称需唯一" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alterView show];
//        [alterView release];
//    }
//    
//    if (isSuccess) {
//        NSLog(@"修改成功");
//
//        [appDelegate closeLoading];
//        [appDelegate showToast:@"修改成功" hideAfterSecond:2];
//    }
}


-(void)dealloc{
    [userInfo release];
    [txtZN release];
    [txtSex release];
    [txtRetire release];
    [btnPassword release];
    [btnInfo release];
    [btnSave release];
    [btnRefresh release];
    [lblLoginName4 release];
    [lblLoginName3 release];
    [lblLoginName2 release];
    [lblLoginName1 release];
    [view_infomation release];
    [view_passwordnickname release];
    [view_contact release];
    [view_other release];
//    [dataArr release];
//    [selectedTextFiled release];
//    [dataPickView release];
//    [birthdayPicker release];
//    [sortPopover release];
    
    [txtAddress release];
    [txtBirthday release];
    [txtBirthplace release];
    [txtCaddress release];
    [txtCompany release];
    [txtConfirmPassword release];
    [txtCphone release];
    [txtCpostcode release];
    [txtDegree release];
    [txtDept release];
    [txtGrade release];
   
    [txtIdCard release];
    [txtMajor release];
    [txtMobile1 release];
    [txtMobile2 release];
    [txtEmail release];
    [txtNation release];
    [txtNewPassword release];
    [txtNickName2 release];
    [txtPhone release];
    [txtPolitical release];
    [txtPostcode release];
    [txtRemark release];
  
    [txtTitle release];
    [super dealloc];
}
@end
