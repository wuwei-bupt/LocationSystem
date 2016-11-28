package com.location.dao.user;

import com.grain.dao.BaseDao;
import com.location.entity.DeviceInfo;

public interface DeviceInfoDao extends BaseDao<DeviceInfo, String> {
		DeviceInfo	findByName(String device_mac);
}
