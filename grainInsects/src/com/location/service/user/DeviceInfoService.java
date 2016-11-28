package com.location.service.user;

import com.grain.service.BaseService;
import com.location.entity.DeviceInfo;

public interface DeviceInfoService extends BaseService<DeviceInfo, String> {
	DeviceInfo findByName(String deviceMac);
}
