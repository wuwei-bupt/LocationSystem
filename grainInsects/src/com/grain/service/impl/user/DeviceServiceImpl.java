package com.grain.service.impl.user;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Override
	@Transactional(readOnly = true)
	public Device findByName(String device_code) {
		// TODO Auto-generated method stub
		return deviceDao.findByName(device_code);
	}
}
