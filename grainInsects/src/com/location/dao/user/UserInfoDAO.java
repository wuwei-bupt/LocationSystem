package com.location.dao.user;

import com.grain.dao.BaseDao;
import com.location.entity.UserInfo;

public interface UserInfoDao extends BaseDao<UserInfo,String>{
/*	Integer[] locationTransfer(UserInfo user_info,int scale);
	Map<String, Integer[]> locationsTransfer(Set<UserInfo> sets,int scale);*/
	UserInfo findByDeviceID(int deviceID);
}
