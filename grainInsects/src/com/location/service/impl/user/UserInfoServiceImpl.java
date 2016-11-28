package com.location.service.impl.user;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.grain.service.BaseService;
import com.grain.service.impl.BaseServiceImpl;
import com.location.dao.user.UserInfoDao;
import com.location.entity.UserInfo;

@Service("userInfoServiceImpl")
public class UserInfoServiceImpl extends BaseServiceImpl<UserInfo, String>
		implements
			BaseService<UserInfo, String> {

	@Resource(name = "userDaoImpl")
	private UserInfoDao userInfoDao;
	@Resource(name = "userDaoImpl")
	public void setBaseDao(UserInfoDao userInfoDao) {
		super.setBaseDao(userInfoDao);
	}
}