package com.location.service.impl.user;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.grain.service.impl.BaseServiceImpl;
import com.location.dao.user.UserInfoDao;
import com.location.entity.UserInfo;
import com.location.service.user.UserInfoService;

@Service("userInfoServiceImpl")
public class UserInfoServiceImpl extends BaseServiceImpl<UserInfo, String> implements UserInfoService{

	@Resource(name = "userInfoDaoImpl")
	private UserInfoDao userInfoDao;
	@Resource(name = "userInfoDaoImpl")
	public void setBaseDao(UserInfoDao userInfoDao) {
		super.setBaseDao(userInfoDao);
	}
	@Override
	public UserInfo findByDeviceID(int deviceID) {
		// TODO Auto-generated method stub
		return userInfoDao.findByDeviceID(deviceID);
	}
	public List<UserInfo> findAll(){
		return userInfoDao.findAll();	
	}
	public List<UserInfo> findByGroupID(int groupID){
		return userInfoDao.findByGroupID(groupID);
	}
	@Override
	public List<UserInfo> findByState(int state) {
		// TODO Auto-generated method stub
		return userInfoDao.findByState(state);
	}
}