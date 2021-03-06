//
//  MeetingDao.h
//  ShmetroOA
//
//  Created by gisteam on 6/16/13.
//
//

#import "BaseDao.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "MeetingInfo.h"
#import "MeetingRoomInfo.h"
#import "MeetingOrgInfo.h"

@interface MeetingDao : BaseDao

-(BOOL)insertMeetingInfo:(MeetingInfo*)meetingInfo;
-(BOOL)updateMeetingInfo:(MeetingInfo*)meetingInfo;

-(BOOL)insertMeetingRoomInfo:(MeetingRoomInfo *)meetingRoomInfo;
-(BOOL)updateMeetingRoomInfo:(MeetingRoomInfo*)meetingRoomInfo;

-(BOOL)insertMeetingOrgInfo:(MeetingOrgInfo*)meetingOrgInfo;
-(BOOL)updateMeetingOrgInfo:(MeetingOrgInfo*)meetingOrgInfo;


//获取会议详情
-(MeetingInfo*)getMeetingById:(NSString *)mId;
-(BOOL)deleteAllMeetingInfo;
//获取所有部门
-(NSMutableDictionary *)queryAllOrg;
-(BOOL)deleteAllOrg;

//获取部门的会议室
-(MeetingRoomInfo *)getMeetingRoomInfoByMrid:(NSString *)mrId;
-(NSMutableArray *)queryMeetingRoomByOrg:(NSString *)orgId;
-(BOOL)deleteMeetingRoom;

-(NSMutableArray *)queryMeetingListByStartDate:(NSString *)startDate Org:(NSString*)org Adderss:(NSString *)address;
-(NSMutableArray *)queryMeetingListFromStartDate:(NSNumber *)startDate ToEndDate:(NSNumber *)endDate Org:(NSString*)org Address:(NSString *)address;

//获取某会议室的会议安排列表
-(NSMutableArray *)queryMeetingListFromStartDate:(NSNumber *)startDate ToEndDate:(NSNumber *)endDate mrId:(NSString *)mrId;
//获取某人某会议室的会议安排列表
-(NSMutableArray *)queryMeetingListForName:(NSString *)name FromStartDate:(NSNumber *)startDate ToEndDate:(NSNumber *)endDate mrId:(NSString *)mrId;


-(void)saveMeetinglistFromJsonValue:(id)jsonObj;
-(void)saveMeetingDetailFromJsonValue:(id)jsonObj;

-(void)saveMeetingRoomInfoFromJsonValue:(id)jsonObj;
-(void)saveMeetingOrgInfoFromJsonValue:(id)jsonObj;

@end
