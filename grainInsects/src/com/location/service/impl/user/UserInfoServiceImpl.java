package com.location.service.impl.user;

import org.springframework.stereotype.Service;

import com.grain.service.BaseService;
import com.grain.service.impl.BaseServiceImpl;
import com.location.dao.user.UserInfoDAO;
import com.location.entity.UserInfo;

@Service("userInfoServiceImpl")
public class UserInfoServiceImpl extends BaseServiceImpl<UserInfo, String> implements BaseService<UserInfo, String> {

private UserInfoDAO userInfoDAO;
public void setBaseDao(UserInfoDAO userInfoDAO) {
	super.setBaseDao(userInfoDAO);
}}