package com.grain.service.user;

import com.grain.service.BaseService;
import com.location.entity.Device;

public interface DeviceService extends BaseService<Device, String> {
	Device findByName(String device_code);
}
