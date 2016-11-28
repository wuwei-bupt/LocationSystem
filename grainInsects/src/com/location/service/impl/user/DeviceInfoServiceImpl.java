package com.location.service.impl.user;

import javax.annotation.Resource;

import com.grain.service.impl.BaseServiceImpl;
import com.location.dao.user.DeviceInfoDao;
import com.location.entity.DeviceInfo;
import com.location.service.user.DeviceInfoService;

public class DeviceInfoServiceImpl extends BaseServiceImpl<DeviceInfo, String> implements DeviceInfoService {

	@Resource(name = "deviceInfoDaoImpl")
	private DeviceInfoDao deviceInfoDao;
	
	@Resource(name = "deviceInfoDaoImpl")
	public void setBaseDao(DeviceInfoDao deviceInfoDao) {
		super.setBaseDao(deviceInfoDao);
	}
	
	@Override
	public DeviceInfo findByName(String deviceMac) {
		// TODO Auto-generated method stub
		return deviceInfoDao.findByName(deviceMac);
	}

}
