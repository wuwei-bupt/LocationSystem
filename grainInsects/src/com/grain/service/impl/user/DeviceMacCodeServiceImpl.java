package com.grain.service.impl.user;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.grain.dao.user.DeviceMacCodeDao;
import com.grain.service.impl.BaseServiceImpl;
import com.grain.service.user.DeviceMacCodeService;
import com.location.entity.DeviceMacCode;

@Service("deviceMacCodeServiceImpl")
public class DeviceMacCodeServiceImpl extends BaseServiceImpl<DeviceMacCode, String> implements DeviceMacCodeService {
	@Resource(name = "deviceMacCodeDaoImpl")
	private DeviceMacCodeDao deviceDao;
	
	@Resource(name = "deviceMacCodeDaoImpl")
	public void setBaseDao(DeviceMacCodeDao deviceDao){
		super.setBaseDao(deviceDao);
	}

	@Override
	@Transactional(readOnly = true)
	public DeviceMacCode findByName(String device_code) {
		// TODO Auto-generated method stub
		return deviceDao.findByName(device_code);
	}
}
