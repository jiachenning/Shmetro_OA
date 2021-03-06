//
//  ApiConfig.m
//  ShmetroOA
//
//  Created by  on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ApiConfig.h"
#import "UIDevice-Extensions.h"
#import "UserAccountContext.h"
#import "StringUtil.h"
@interface ApiConfig(PrivateMethods)
+ (void)registerDefaultsFromSettingsBundle;
@end
@implementation ApiConfig
/* 现场环境*/
//NSString *API_HOST=@"http://10.1.48.20";
//NSString *API_PORT=@"80";

/* 开发环境*/
NSString *API_HOST=@"http://10.1.40.202";
NSString *API_PORT=@"8088";
//NSString *API_PORT_NEW=@"8088";


/* 已废弃的开发环境*/
//NSString *API_HOST=@"http://10.1.43.70";
//NSString *API_PORT=@"8081";

/* 测试环境*/
//NSString *API_HOST=@"http://10.1.40.202";
//NSString *API_PORT=@"8088";

NSString *APP_KEY = @"";
NSString *METHOD_LOGIN=@"SESSIONINFO.GET";
NSString *METHOD_TODO_LIST = @"MOBILE.GET_TODO_LIST";
NSString *METHOD_TODO_DETAIL = @"MOBILE.GET_TODO_DETAIL";
NSString *METHOD_GET_ATTACH_LIST = @"MOBILE.GET_ATTACH_LIST";
NSString *METHOD_GET_ATTACH_DETAIL=@"MOBILE.GET_ATTACH_DETAIL";
NSString *METHOD_FILE_UPLOAD=@"MOBILE.UPLOAD";
NSString *MOBILE_SUBMIT_TODO=@"MOBILE.SUBMIT_TODO";
NSString *MOBILE_BEGIN_UPLOAD =@"MOBILE.BEGIN_UPLOAD";
NSString *MOBILE_END_UPLOAD = @"MOBILE.END_UPLOAD";

NSString *KEY_MOBILE=@"mobile";
NSString *KEY_SECRET=@"124a67748fcb48a8a0863f30970a2a06";


static NSString *NETWORK_TYPE_3G = @"3G";
static NSString *NETWORK_TYPE_WIFI=@"wifi";
static NSString *NETWORK_TYPE_NONE=@"none";
+(NSString *)getAPIHost{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *host = [defaults stringForKey:@"server_preference"];
    
    if(!host) {
        [self registerDefaultsFromSettingsBundle];
        host = [defaults stringForKey:@"server_preference"];
        
    }
    
    if (host == nil || [host isEqualToString:@""]) {
        return API_HOST;
    }
    host = [NSString stringWithFormat:@"http://%@",host];
    return host;
}

+(NSString *)getAPIPort{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *port = [defaults stringForKey:@"port_preference"];
    
    if(!port) {
        [self registerDefaultsFromSettingsBundle];
        port = [defaults stringForKey:@"port_preference"];
        
    }
    
    if (port == nil || [port isEqualToString:@""]) {
        return API_PORT;
    }
    return port;
}

+(NSString *)getWorkFlowHost{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *host = [defaults stringForKey:@"workflow_perference"];
    
    if(!host) {
        [self registerDefaultsFromSettingsBundle];
        host = [defaults stringForKey:@"workflow_perference"];
        
    }
    
    if (host == nil || [host isEqualToString:@""]) {
        return API_HOST;
    }
    host = [NSString stringWithFormat:@"http://%@",host];
    return host;
}

+(NSString *)getWorkFlowPort{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *port = [defaults stringForKey:@"workflow_port"];
    
    if(!port) {
        [self registerDefaultsFromSettingsBundle];
        port = [defaults stringForKey:@"workflow_port"];
        
    }
    
    if (port == nil || [port isEqualToString:@""]) {
        return API_PORT;
    }
    return port;
}


+(NSString *)getKeyMobile{
    return KEY_MOBILE;
}
+(NSString *)getKeySecret{
    return KEY_SECRET;
}

+(NSString *)getUserLoginMethod{
    return METHOD_LOGIN;
}

+(NSString *)getTodoListMethod{
    return METHOD_TODO_LIST;
}

+(NSString *)getTodoDetailMethod{
    return METHOD_TODO_DETAIL;
}

+(NSString *)getAttachFileMethod{
    return METHOD_GET_ATTACH_LIST;
}

+(NSString *)getAttachFileDetailMethod{
    return METHOD_GET_ATTACH_DETAIL;
}

+(NSString *)getTodoSubmitMethod{
    return MOBILE_SUBMIT_TODO;
}

+(NSString *)getBeginUploadMethod{
    return MOBILE_BEGIN_UPLOAD;
}

+(NSString *)getFileUploadMethod{
    return METHOD_FILE_UPLOAD;
}

+(NSString *)getEndUploadMethod{
    return MOBILE_END_UPLOAD;
}

+(NSURL *)getMobileSessionKeyAPIUrl{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/ca/services/api/getMobileSessionKey%@",[self getAPIHost],[self getAPIPort],APP_KEY];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}

+(NSURL *)getDataExchangeAPIUrl{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/ca/services/api/dataExchange%@",[self getAPIHost],[self getAPIPort],APP_KEY];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}

+(NSURL *)getDeptAPIUrl{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/ca/services/api/getUserDeptByLoginName%@",[self getAPIHost],[self getAPIPort],APP_KEY];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
  // DLog(@"%@", urlStr);
    return result;
}

+(NSURL *)getVersionUpdateAPIUrl{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/ca/services/api/updateMobileVersion%@",[self getAPIHost],[self getAPIPort],APP_KEY];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}

+(NSURL *)getApproveMonitorUrl:(NSString *)todoId{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/workflowLocal/ultimus/scanList.action?id=%@",[self getWorkFlowHost],[self getWorkFlowPort],todoId];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}


+(NSURL *)getUploadFileUrl{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/ca/services/api/dataExchange3",[self getAPIHost],[self getAPIPort]];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}

+(NSURL *)getTodoListAPIURLWithType:(NSString *)typeName ByLoginName:(NSString *)loginName{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/toDoItem/list?typeName=%@&loginName=%@&statNew=1",[self getAPIHost],[self getAPIPort],typeName,loginName];
    NSURL *result = [[[NSURL alloc]initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    return result;
}

+(NSURL *)getUpdateSingleDataAPIURLWithType:(NSString *)typeName Pid:(NSString *)pid{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/processDone/updateSingleData?ptype=%@&pid=%@",[self getAPIHost],[self getAPIPort],typeName,pid];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}
+(NSURL *)getProcessdataAPIURLWithType:(NSString *)typeName Pid:(NSString *)pid DataType:(NSString *)dataType{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/processDone/getProcessData?ptype=%@&pid=%@&dataType=%@",[self getAPIHost],[self getAPIPort],typeName,pid,dataType];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}
+(NSURL *)getDocSendLeaderDealAPIURLWithPid:(NSString *)pid Choice:(NSString *)choice Suggest:(NSString *)suggest LoginName:(NSString *)loginName{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/workflow/docSendLeaderDeal?pid=%@&choice=%@&suggest=%@&loginName=%@",[self getAPIHost],[self getAPIPort],pid,choice,suggest,loginName];
    NSURL *result = [[[NSURL alloc]initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    return result;
}

+(NSURL *)getUserInfoAPIUrl:(NSString *)loginName{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/user/getByLoginName?loginName=%@",[self getAPIHost],[self getAPIPort],loginName];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}

+(NSURL *)checkNicknameUniqueAPIUrl:(NSString *)nickName{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/user/checkNickName?nickName=%@",[self getAPIHost],[self getAPIPort],nickName];
    NSURL *result = [[[NSURL alloc]initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    return result;
}
+(NSURL *)modifyUserPasswordAndNickAPIUrl:(NSString *)uid Password:(NSString *)password Nickname:(NSString *)nickName{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/user/modifyUserPasswordAndNick",[self getAPIHost],[self getAPIPort]];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr]autorelease];
    return result;
}
+(NSURL *)modifyUserInfoAPIUrl:(NSString *)uid Email:(NSString *)email Phone:(NSString *)phone Moible1:(NSString *)mobile1 Mobile2:(NSString *)mobile2{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/user/modifyUserInfo",[self getAPIHost],[self getAPIPort]];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr]autorelease];
    return result;
}

+(NSURL *)getContactsAPIUrlByDeptName:(NSString *)deptName{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/user/findByDept?dept=%@",[self getAPIHost],[self getAPIPort],deptName];
    NSURL *result = [[[NSURL alloc]initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    return result;
}

+(NSURL *)getContactsAPIUrlByUserName:(NSString *)userName{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/user/findByUsername?username=%@",[self getAPIHost],[self getAPIPort],userName];
    NSURL *result = [[[NSURL alloc]initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    return result;
}
+(NSURL *)getOrgsAPIUrl{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/meetingRoom/getOrgs",[self getAPIHost],[self getAPIPort]];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}
+(NSURL *)getMeetingRoomInfoAPIUrlByOrg:(NSString *)org{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/meetingRoom?mrOrg=%@",[self getAPIHost],[self getAPIPort],org];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}
+(NSURL *)getMeetingListAPIUrlFromStartDate:(NSString *)startdate ToEndDate:(NSString *)enddate{
   
//    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/meetFlow/listMeetFlowByUsername?date1=%@&date2=%@",[self getAPIHost],[self getAPIPort],startdate,enddate];  //2013-12-12调试前
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/meetFlow/listMeetFlowByStartDateBetween?date1=%@&date2=%@",[self getAPIHost],[self getAPIPort],startdate,enddate];
    NSURL *result = [[[NSURL alloc]initWithString:urlStr] autorelease];
    return result;
}
+(NSURL *)getMeetingDetailAPIUrl:(NSString *)meetId{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/meetFlow/%@",[self getAPIHost],[self getAPIPort],meetId];
    NSURL *result = [[[NSURL alloc]initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    return result;
}
+(NSURL *)getMeetingListAPIUrlByUserName:(NSString *)userName FromStartDate:(NSString *)startdate ToEndDate:(NSString *)enddate{
     NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/meetFlow/listMeetFlowByUsername?username=%@",[self getAPIHost],[self getAPIPort],userName];
    if (![startdate isEqual:@""] && ![enddate isEqual:@""]) {
        urlStr = [NSString stringWithFormat:@"%@:%@/sc/meetFlow/listMeetFlowByUsername?username=%@&date1=%@&date2=%@",[self getAPIHost],[self getAPIPort],userName,startdate,enddate];
    }
   
     NSURL *result = [[[NSURL alloc]initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    return result;
}

+(NSURL*)getMessagesFromOffset:(NSString *)offset WithLimit:(NSString *)limit{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/content/getContents?offset=%@&limit=%@",[self getAPIHost],[self getAPIPort],offset,limit];
    NSURL *result = [[[NSURL alloc]initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    return result;
}
+(NSURL *)getMessageDetailById:(NSString *)messageId App:(NSString *)appName{
    NSString *urlStr = [NSString stringWithFormat:@"%@:%@/sc/content/getContentById?id=%@&&app=%@",[self getAPIHost],[self getAPIPort],messageId,appName];
    NSURL *result = [[[NSURL alloc]initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    return result;
}

+(NSMutableDictionary *)getHttpRequestDic:(NSString *)method DataParams:(NSString *)dataParams Key:(NSString *)key{
    NSMutableDictionary *headerDic = [[[NSMutableDictionary alloc]init] autorelease];
    [headerDic setValue:[ApiConfig getKeyMobile] forKey:@"appName"];
    [headerDic setValue:[ApiConfig getKeySecret] forKey:@"secret"];
    [headerDic setValue:method forKey:@"method"];
    [headerDic setValue:@"1" forKey:@"deviceType"];
    [headerDic setValue:[[UIDevice currentDevice] macaddress] forKey:@"deviceId"];
    [headerDic setValue:@"json" forKey:@"dateType"];
    if (dataParams!=nil) {
        [headerDic setValue:dataParams forKey:@"dataParams"];
    }
    NSString *signStr = [NSString stringWithFormat:@"%@%@%@%@",[ApiConfig getKeyMobile],key,method,[ApiConfig getKeySecret]];
    [headerDic setValue:[StringUtil md5Digest:signStr] forKey:@"sign"];
    [headerDic setValue:key forKey:@"token"];
    return headerDic;
}

+(void)setHttpPostData:(ASIHTTPRequest *)request Method:(NSString *)method DataParams:(NSString *)dataParams Key:(NSString *)key{
    NSString *signStr = [NSString stringWithFormat:@"%@%@%@%@",[ApiConfig getKeyMobile],key,method,[ApiConfig getKeySecret]];
    NSString *bodyString = nil;
    if (dataParams!=nil) {
        bodyString = [NSString stringWithFormat:@"appName=%@&secret=%@&method=%@&deviceType=%@&deviceId=%@&dateType=%@&dataParams=%@&sign=%@&token=%@",[ApiConfig getKeyMobile],[ApiConfig getKeySecret],method,@"1",[[UIDevice currentDevice] macaddress],@"json",dataParams,[StringUtil md5Digest:signStr],key];
    }else{
        bodyString = [NSString stringWithFormat:@"appName=%@&secret=%@&method=%@&deviceType=%@&deviceId=%@&dateType=%@&sign=%@&token=%@",[ApiConfig getKeyMobile],[ApiConfig getKeySecret],method,@"1",[[UIDevice currentDevice] macaddress],@"json",[StringUtil md5Digest:signStr],key];
    }
    NSMutableData *bodyData = [[NSMutableData alloc]initWithData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setPostBody:bodyData];  
    [bodyData release];
}

+(void)setHttpPostDataByLogin:(ASIHTTPRequest *)request Method:(NSString *)method DeptId:(NSString *)deptId Key:(NSString *)key{
    NSString *signStr = [NSString stringWithFormat:@"%@%@%@%@",[ApiConfig getKeyMobile],key,method,[ApiConfig getKeySecret]];
    NSString *bodyString = nil;
    bodyString = [NSString stringWithFormat:@"appName=%@&secret=%@&method=%@&deviceType=%@&deviceId=%@&dateType=%@&deptId=%@&sign=%@&token=%@",[ApiConfig getKeyMobile],[ApiConfig getKeySecret],method,@"1",[[UIDevice currentDevice] macaddress],@"json",deptId,[StringUtil md5Digest:signStr],key];
    NSMutableData *bodyData = [[NSMutableData alloc]initWithData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setPostBody:bodyData];
    [bodyData release];
}

+(NSString *)networkType3G{
    return NETWORK_TYPE_3G;
}
+(NSString *)networkTypeWifi{
    return NETWORK_TYPE_WIFI;
}
+(NSString *)networkTypeNone{
    return NETWORK_TYPE_NONE;
}


#pragma mark - Settings.bundle
+ (void)registerDefaultsFromSettingsBundle
{
    NSLog(@"Registering default values from Settings.bundle");
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    [defs synchronize];
    
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    
    if(!settingsBundle)
    {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    
    for (NSDictionary *prefSpecification in preferences)
    {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if (key)
        {
            // check if value readable in userDefaults
            id currentObject = [defs objectForKey:key];
            if (currentObject == nil)
            {
                // not readable: set value from Settings.bundle
                id objectToSet = [prefSpecification objectForKey:@"DefaultValue"];
                [defaultsToRegister setObject:objectToSet forKey:key];
                NSLog(@"Setting object %@ for key %@", objectToSet, key);
            }
            else
            {
                // already readable: don't touch
                NSLog(@"Key %@ is readable (value: %@), nothing written to defaults.", key, currentObject);
            }
        }
    }
    
    [defs registerDefaults:defaultsToRegister];
    [defaultsToRegister release];
    [defs synchronize];
}

@end
