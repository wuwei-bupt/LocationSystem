package com.grain.service.impl.user;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.grain.dao.user.DeviceDao;
import com.grain.service.impl.BaseServiceImpl;
import com.grain.service.user.DeviceService;
import com.location.entity.Device;

@Service("deviceServiceImpl")
public class DeviceServiceImpl extends BaseServiceImpl<Device, String> implements DeviceService {
	@Resource(name = "deviceDaoImpl")
	private DeviceDao deviceDao;
	
	@Resource(name = "deviceDaoImpl")
	public void setBaseDao(DeviceDao deviceDao){
		super.setBaseDao(deviceDao);
	}
}
